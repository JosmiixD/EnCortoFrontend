import 'dart:convert';
import 'dart:io';

import 'package:en_corto/src/models/response_api.dart';
import 'package:en_corto/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:en_corto/src/api/environment.dart';
import 'package:en_corto/src/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';


class AuthService with ChangeNotifier {

  User user;
  bool _authenticating = false;

  final _storage = new FlutterSecureStorage();
  final SharedPref _sharedPref = new SharedPref();

  String _url = Environment.API_DELIVERY;
  String _api = '/api/users';

  bool get authenticating => this._authenticating;
  set authenticating( bool value ) {
    this._authenticating = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<dynamic> signup( {String name, String lastName, String email, String password, String passwordConfirmation} ) async {


    this.authenticating = true;

    final data = {
      'name': name,
      'lastname': lastName,
      'email': email,
      'password': password,
      'password_confirmation' : passwordConfirmation,
    };

    final headers = {
      'Content-type': 'application/json'
    };

    final Uri uri = Uri.parse('$_url$_api/create');

    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: json.encode(data)
      );

      this.authenticating = false;

      final ResponseApi responseApi = responseApiFromJson( response.body );
      
      if( responseApi.success ) {

        this.user = userFromJson( json.encode(responseApi.data) );
        await this._saveToken( this.user.sessionToken );
        await this._saveUser( json.encode(this.user) );

      }
      return responseApi;

    } catch (e) {
      print('Error: $e');
      this.authenticating = false;
      return null;
    }
  }

  Future<dynamic> updateUserInformation( String name, String lastName, String phone, File image) async {

    this.authenticating = true;
    String imagePath = this.user.image;

    try {

      if( image != null ) {

        imagePath = await this.uploadPicture( image );

      }

      final data = {
        'id'      : this.user.id,
        'name'    : name,
        'lastname': lastName,
        'phone'   : phone,
        'image'   : imagePath,
      };

      final headers = {
        'Content-type': 'application/json',
        'Authorization': this.user.sessionToken
      };

      final Uri uri = Uri.parse('$_url$_api/update');

      final response = await http.put(
        uri,
        headers: headers,
        body: json.encode(data)
      );


      this.authenticating = false;

      if( response.statusCode == 401 ) {
          this.logout();
          return false;
      }

      final ResponseApi responseApi = responseApiFromJson( response.body );
      
      if( responseApi.success ) {

        this.user = userFromJson( json.encode(responseApi.data) );  
        await this._saveToken( this.user.sessionToken );
        print( this.user.toJson());
        await this._saveUser( json.encode(this.user) );

      }
      
      return responseApi;
      
    } catch (e) {
      print('Error: $e');
      this.authenticating = false;
      return null;
    }

  }

  Future<String> uploadPicture( File image ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dgni8baqe/image/upload?upload_preset=f7p3w8zs');
    final mimeType = mime( image.path ).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url,
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add( file );

    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream( streamResponse );

    if( response.statusCode != 200 && response.statusCode != 201 ) {
      print('Something went wrong while uploading your image');
      print( response.body );
      return null;
    }

    final responseData = json.decode( response.body );

    return responseData['secure_url'];

  }


  Future<dynamic> login( {String email, String password }) async {

    this.authenticating = true;

    final data = {
      'email': email,
      'password': password,
    };

    final headers = {
      'Content-type': 'application/json'
    };

    final Uri uri = Uri.parse('$_url$_api/login');

    try {

      final response = await http.post(
        uri,
        headers: headers,
        body: json.encode(data)
      );

      this.authenticating = false;

      final ResponseApi responseApi = responseApiFromJson( response.body );

      if( responseApi.success ) {

        this.user = userFromJson( json.encode(responseApi.data) );
        await this._saveToken( this.user.sessionToken );
        await this._saveUser( json.encode(this.user) );

      }

      return responseApi;

    } catch (e) {

      print('Error: $e');
      this.authenticating = false;
      return null;

    }

  }

  Future<bool> isLoggedIn() async {

    this.authenticating = true;

    try {

      final token = await this._storage.read(key: 'token');
      if( token != null ) {

        final jsonUser = await this._storage.read(key: 'user');
        final User user = userFromJson( jsonUser );

        final data = {
          'id': user.id,
        };

        final headers = {
          'Content-type': 'application/json',
          'Authorization': token
        };

        final Uri uri = Uri.parse('$_url$_api/token-renew');

        final response = await http.post(
          uri,
          headers: headers,
          body: json.encode(data)
        );

        this.authenticating = false;

        
        if( response.statusCode == 200 ) {

          final ResponseApi responseApi = responseApiFromJson( response.body );
          this.user = userFromJson( json.encode(responseApi.data) );
          await this._saveToken( this.user.sessionToken );
          await this._saveUser( json.encode(this.user) );
          return true;

        }else {
          this.logout();
          this.authenticating = false;
          return false;
        }

      } else {
        this.authenticating = false;
        return false;
      }
      
    } catch (e) {
      return false;
    }
    
  }

  // Future<bool> isLoggedIn() async {

  //   final token = await this._storage.read(key: 'token');
  //   final jsonUser = await this._storage.read(key: 'user');

  //   if( token != null ) {
  //     final User user = userFromJson( jsonUser );
  //     this.user = user;
  //     return true;
  //   }else {
  //     return false;
  //   }

  // }

  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var isFirstTime = prefs.getBool('first_time');
    
    if( isFirstTime != null &&  !isFirstTime ) {
      prefs.setBool('first_time', false);
      return false;
    } else {
      prefs.setBool('first_time', false);
      return true;
    }

  }

  Future _saveToken( String token ) async {
    return await _storage.write(key: 'token', value: token );
  }

  Future _saveUser( String user ) async {
    return await _storage.write(key: 'user', value: user );
  }

  Future logout() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'user');
  }

}