import 'package:en_corto/src/helpers/helpers.dart';
import 'package:en_corto/src/services/auth_service.dart';
import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/widgets/custom_button.dart';
import 'package:en_corto/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class SignUpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Registro'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWelcomeMessage( size, context ),
            SizedBox( height: size.height * 0.02 ),
            _SignUpForm()
          ],
        )
      ),
    );
  }

    Widget _buildWelcomeMessage( Size size, context ) {

    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20),
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Crea tu cuenta', style: TextStyle( fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox( height: 10 ),
          Text('Ingresa tu información para poder registrarte y disfrutar de los beneficios que te ofrecemos', style: TextStyle( fontSize: 14,fontWeight: FontWeight.w500,))
        ],
      )
    );

  } 
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({ Key key }) : super(key: key);

  @override
  __SignUpFormState createState() => __SignUpFormState();
}

class __SignUpFormState extends State<_SignUpForm> {

  final nameController                  = TextEditingController();
  final lastNameController              = TextEditingController();
  final emailController                 = TextEditingController();
  final passwordController              = TextEditingController();
  final passwordConfirmationController  = TextEditingController();

  final _signUpKey                      = GlobalKey<FormState>();

  @override
  void dispose() { 
    nameController?.dispose();
    lastNameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    passwordConfirmationController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);

    return Form(
      key: _signUpKey,
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 20 ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomInput(
                hintText: 'Nombres',
                controller: nameController,
                prefixIcon: FontAwesomeIcons.user,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                validator: ( value ) {
                  if( value.isEmpty ) {
                    return 'Debe ingresar su nombre';
                  }
                  return null;
                },
              ),
              SizedBox( height: 20),
              CustomInput(
                hintText: 'Apellidos',
                controller: lastNameController,
                prefixIcon: FontAwesomeIcons.user,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                validator: ( value ) {
                  if( value.isEmpty ) {
                    return 'Debe ingresar sus apellidos';
                  }
                  return null;
                },
              ),
              SizedBox( height: 20),
              CustomInput(
                hintText: 'Correo electronico',
                controller: emailController,
                prefixIcon: FontAwesomeIcons.envelope,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: ( value ) {

                  if( value.isEmpty ) {
                    return 'Ingrese su correo electronico';
                  } else {
                    bool emailValid = RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                    .hasMatch(value);

                    if( !emailValid ) {
                      return 'El correo no cumple el formato example@example.com';
                    }
                    return null;
                  }

                },
              ),
              SizedBox( height: 20),
              CustomInput(
                hintText: 'Contraseña',
                controller: passwordController,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.next,
                prefixIconSize: 22,
                isPassword: true,
                validator: ( value ) {
                  if( value.isEmpty ) {
                    return 'Debe ingresar una contraseña';
                  }
                  return null;
                },
              ),
              SizedBox( height: 20),
              CustomInput(
                hintText: 'Confirmar contraseña',
                controller: passwordConfirmationController,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.done,
                prefixIconSize: 22,
                isPassword: true,
                validator: ( value ) {
                  if( value.isEmpty ){
                    return 'Ingrese nuevamente la contraseña';
                  } else {
                    if( value != passwordController.text.trim() ) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  }
                },
              ),
              SizedBox( height: 30 ),
              CustomButton(
                text: authService.authenticating ? 'Espere...' : 'Crear cuenta',
                onPressed: authService.authenticating
                ? null
                : () async {  

                  FocusScope.of(context).unfocus();
                  if( _signUpKey.currentState.validate() ) {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final passwordConfirmation = passwordConfirmationController.text.trim();
                    final name = nameController.text.trim();
                    final lastName = lastNameController.text.trim();

                    final response = await authService.signup( email: email, password: password, passwordConfirmation: passwordConfirmation, name: name, lastName: lastName);
                  
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
                            Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
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
              SizedBox( height: 15 ),
              Text('Ó', style: TextStyle( color: nixEnCortoMutedColor)),
              SizedBox( height: 15 ),
              CustomButton(
                text: 'Conectar Con Facebook',
                backgroundColor: Color(0xff3B5998),
                icon: FontAwesomeIcons.facebookSquare,
                onPressed: (){}
              ),
              SizedBox( height: 20 ),
              ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Color(0xFFEAEAEB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular( 10 )
                  )
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Image.asset('assets/img/general/google_icon.png', width: 20),
                          SizedBox( width: 5 ),
                          Text( 'Continuar con Google', style: TextStyle( color: Colors.black ),),
                      ],
                    ),
                  )
                ),
              ),
              SizedBox( height: 20 ),
              InkWell(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'Ya tienes una cuenta? '),
                      TextSpan(text: 'Ingresa', style: nixEnCortoLinkStyle),
                    ]
                  )
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}