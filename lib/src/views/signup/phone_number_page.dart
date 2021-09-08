import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/widgets/custom_button.dart';
import 'package:en_corto/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PhoneNumberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20 ),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ingresa tu número de teléfono', style: TextStyle( fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black)),
                SizedBox( height: 10 ),
                Text('Recuerda agregar un numero telefonico valido, de esa manera podremos ofrecerte un mejor servicio 😀', style: TextStyle( fontSize: 14,fontWeight: FontWeight.w500,)),
                SizedBox( height: size.height * 0.05 ),
                _PhoneForm()
              ],
          ),
            )),
          
        ],
      ),
    );
  }
}

class _PhoneForm extends StatefulWidget {

  @override
  __PhoneFormState createState() => __PhoneFormState();
}

class __PhoneFormState extends State<_PhoneForm> {

  final phoneController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  @override
  void dispose() { 
    phoneController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all( 2 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular( 10 ),
                border: Border.all(
                  color: nixEnCortoMutedColor.withOpacity(0.5)
                ),
                color: Color(0xffEFEFEF),
              ),
              child: Center(
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Container(
                      width: size.width * 0.20,
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric( horizontal: 10 ),
                          border: InputBorder.none,
                          hintText: '🇲🇽 +52'
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox( width: 10),
            Expanded(
              child: CustomInput(
                hintText: 'Numero de telefono',
                prefixIcon: FontAwesomeIcons.mobileAlt,
                controller: phoneController,
                
              )
            ),
          ],
        ),
        SizedBox( height: 40),
        Container(
          width: size.width,
          child: CustomButton(
            text: 'Continuar',
            onPressed: (){},
          ),
        ),
        
      ],
    );
  }
}
