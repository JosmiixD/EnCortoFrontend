import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/widgets/custom_button.dart';
import 'package:en_corto/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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

    return Form(
      key: _signUpKey,
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 20 ),
        child: Column(
          children: [
            CustomInput(
              hintText: 'Nombres',
              controller: nameController,
              prefixIcon: FontAwesomeIcons.user,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
            ),
            SizedBox( height: 20),
            CustomInput(
              hintText: 'Apellidos',
              controller: lastNameController,
              prefixIcon: FontAwesomeIcons.user,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
            ),
            SizedBox( height: 20),
            CustomInput(
              hintText: 'Correo electronico',
              controller: emailController,
              prefixIcon: FontAwesomeIcons.envelope,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox( height: 20),
            CustomInput(
              hintText: 'Contraseña',
              controller: passwordController,
              prefixIcon: Icons.lock_outline,
              textInputAction: TextInputAction.next,
              prefixIconSize: 22,
              isPassword: true,
            ),
            SizedBox( height: 20),
            CustomInput(
              hintText: 'Confirmar contraseña',
              controller: passwordConfirmationController,
              prefixIcon: Icons.lock_outline,
              textInputAction: TextInputAction.done,
              prefixIconSize: 22,
              isPassword: true,
            ),
            SizedBox( height: 30 ),
            CustomButton(
              text: 'Crear Cuenta',
              onPressed: (){}
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
            SizedBox( height: 15 ),
            Text('Ó', style: TextStyle( color: nixEnCortoMutedColor)),
            SizedBox( height: 15 ),
            CustomButton(
              text: 'Conectar Con Facebook',
              backgroundColor: Color(0xff3B5998),
              icon: FontAwesomeIcons.facebookSquare,
              onPressed: (){}
            ),
            SizedBox( height: 15 ),
          ],
        )
      ),
    );
  }
}