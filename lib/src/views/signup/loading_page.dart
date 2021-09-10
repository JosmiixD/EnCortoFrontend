import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:en_corto/src/models/user.dart';
import 'package:en_corto/src/services/auth_service.dart';
import 'package:en_corto/src/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';



class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        checkLoginState(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FadeOut(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular( 13 ),
                    // color: nixEnCortoPrimaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('EN', style: TextStyle( color: nixEnCortoSecondaryColor, fontWeight: FontWeight.bold, fontSize: 25, height: 0.8)),
                      Text('CORTO', style: TextStyle( color: nixEnCortoPrimaryColor, fontWeight: FontWeight.bold, fontSize: 25, height: 0.8)),
                    ],
                  )
                ),
              ],
            )
          )
        )
      ),
    );
  }

  Future checkLoginState(BuildContext context ) async {


    final authService = Provider.of<AuthService>(context);

    final isFirstTime = await authService.isFirstTime();

    //If is the first time using the app show the introduction 
    if( isFirstTime ) {
      Navigator.pushNamedAndRemoveUntil(context, 'introduction', (route) => false);

    } else  if( await authService.isLoggedIn() ) {

      final User user = authService.user;
      await Future.delayed( Duration( milliseconds: 500) );

      if( user.roles.length > 1 ) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, user.roles[0].route, (route) => false);
      }
    } else {
      await Future.delayed( Duration( milliseconds: 500) );
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    }
    

  }

}

class StatefulWrapper extends StatefulWidget {

  final Function onInit;
  final Widget child;

  const StatefulWrapper({
    Key key,
    @required this.onInit,
    @required this.child
  }) : super(key: key);

  

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {

  @override
  void initState() { 
    if( widget.onInit != null ) {
      widget.onInit();
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}