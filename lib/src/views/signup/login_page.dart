import 'dart:convert';

import 'package:en_corto/src/helpers/helpers.dart';
import 'package:en_corto/src/models/response_api.dart';
import 'package:en_corto/src/models/user.dart';
import 'package:en_corto/src/services/auth_service.dart';
import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/widgets/custom_button.dart';
import 'package:en_corto/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ Key key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWelcomeMessage( size ),
            SizedBox( height: size.height * 0.10 ),
            _LoginForm()
          ],
        ),
      )
    );
  }

  Widget _buildWelcomeMessage( Size size ) {

    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20),
      height: size.height * 0.25,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bienvenido', style: TextStyle( fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox( height: 10 ),
          Text('Ingresa tu información para iniciar sesión y disfrutar de tu comida', style: TextStyle( fontSize: 14,fontWeight: FontWeight.w500,))
        ],
      )
    );

  } 

}


class _LoginForm extends StatefulWidget {
  const _LoginForm({ Key key }) : super(key: key);

  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();

  @override
  void dispose() { 
    emailController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Form(
      key: _loginKey,
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 20 ),
        child: Column(
          children: [
            CustomInput(
              hintText: 'Correo electronico',
              controller: emailController,
              prefixIcon: FontAwesomeIcons.envelope,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: ( value ) {
                if( value.isEmpty ) {
                  return 'Ingrese su correo electronico';
                }
                return null;
              }
            ),
            SizedBox( height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomInput(
                  hintText: 'Contraseña',
                  controller: passwordController,
                  prefixIcon: Icons.lock_outline,
                  prefixIconSize: 22,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  validator: ( value ) {
                    if( value.isEmpty ) {
                      return 'Debe ingresar su contraseña';
                    }
                    return null;
                  }
                ),
                SizedBox( height: 10),
                InkWell(
                  child: Text('Olvide mi contraseña', style: nixEnCortoLinkStyle),
                  onTap: (){
                    
                  },
                ),
              ],
            ),
            SizedBox( height: 30 ),
            CustomButton(
              text: authService.authenticating ? 'Iniciando...' : 'Iniciar sesión',
              onPressed: authService.authenticating
              ? null
              : () async {

                FocusScope.of(context).unfocus();
                if( _loginKey.currentState.validate() ) {

                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();

                  final ResponseApi response = await authService.login( email: email, password: password );

                  if( response != null ) {
                    showAlert(
                      context,
                      response.success ? FontAwesomeIcons.checkCircle : FontAwesomeIcons.frownOpen,
                      response.success ? nixEnCortoSuccessColor : nixEnCortoDangerColor,
                      response.success ? "Hola" : "Error",
                      response.message
                    );
                    
                    if( response.success ) {
                      Future.delayed(const Duration(milliseconds: 2000 ), () {

                        setState(() {
                          final User user = userFromJson( json.encode(response.data) );

                          if( user.roles.length > 1 ) {
                            Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
                          } else {
                            Navigator.pushNamedAndRemoveUntil(context, user.roles[0].route, (route) => false);
                          }

                        });

                      });
                    } else {
                      return;
                    }
                  } else {

                    showAlert(
                      context,
                      FontAwesomeIcons.frownOpen,
                      nixEnCortoDangerColor,
                      "Error",
                      "Ocurrio un error durante el proceso, intente nuevamente"
                    );

                  }
                }

              }
            ),
            SizedBox( height: 20 ),
            InkWell(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'No tienes una cuenta? '),
                    TextSpan(text: 'Registrate', style: nixEnCortoLinkStyle),
                  ]
                )
              ),
              onTap: (){
                Navigator.pushNamed(context, 'signup');
              },
            ),
            SizedBox( height: 20 ),
            Text('Ó', style: TextStyle( color: nixEnCortoMutedColor)),
            SizedBox( height: 20 ),
            CustomButton(
              text: 'Conectar Con Facebook',
              backgroundColor: Color(0xff3B5998),
              icon: FontAwesomeIcons.facebookSquare,
              onPressed: (){}
            ),
            SizedBox( height: 20 ),
          ],
        )
      ),
    );
  }
}