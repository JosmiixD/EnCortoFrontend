import 'dart:convert';

import 'package:en_corto/src/models/response_api.dart';
import 'package:en_corto/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:en_corto/src/api/environment.dart';
import 'package:en_corto/src/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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
        _sharedPref.save('user', this.user.toJson());

      }
      return responseApi;

    } catch (e) {
      print('Error: $e');
      this.authenticating = false;
      return null;
    }
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
        _sharedPref.save('user', this.user.toJson());

      }

      return responseApi;

    } catch (e) {

      print('Error: $e');
      this.authenticating = false;
      return null;

    }

  }

  Future<bool> isLoggedIn() async {

    final token = await this._storage.read(key: 'token');

    if( token != null ) {
      return true;
    }else {
      return false;
    }

  }

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

  Future logout() async {
    await _storage.delete(key: 'token');
    _sharedPref.remove('user');
  }

}