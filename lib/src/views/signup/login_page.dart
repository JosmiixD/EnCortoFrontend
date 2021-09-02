import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/widgets/custom_button.dart';
import 'package:en_corto/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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

    Size size = MediaQuery.of(context).size;

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
            ),
            SizedBox( height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomInput(
                  hintText: 'Contraseña',
                  controller: emailController,
                  prefixIcon: Icons.lock_outline,
                  prefixIconSize: 22,
                  isPassword: true,
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
              text: 'Iniciar Sesión',
              onPressed: (){}
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