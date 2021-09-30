import 'package:dotted_border/dotted_border.dart';
import 'package:en_corto/src/helpers/helpers.dart';
import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/widgets/custom_back_button.dart';
import 'package:en_corto/src/widgets/custom_button.dart';
import 'package:en_corto/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterMyRestaurant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMessage(size, context),
            SizedBox( height: 20),
            _RegisterForm()
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(Size size, context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Unete a nosotros',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            SizedBox(height: 10),
            Text(
                "Para poder registrar tu negocio deberas de proporcionar la siguiente información asi como los documentos necesarios.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ))
          ],
        ));
  }
}

class _RegisterForm extends StatefulWidget {

  @override
  __RegisterFormState createState() => __RegisterFormState();
}

class __RegisterFormState extends State<_RegisterForm> {

  final restaurantNameController        = TextEditingController();
  final restaurantAddressController     = TextEditingController();
  final restaurantOwnerNameController   = TextEditingController();
  final restaurantPhoneController       = TextEditingController();
  final clabeController                 = TextEditingController();

  final _registerKey                    = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Form(
      key: _registerKey,
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 20 ),
        child: Column(
          children: [
            CustomInput(
              hintText: 'Nombre del restaurante/negocio',
              controller: restaurantNameController,
              prefixIcon: Icons.storefront_rounded,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              validator: ( value ) {
                if( value.isEmpty ) {
                  return 'Debe ingresar su nombre';
                }
                return null;
              },
            ),
            SizedBox( height: 20,),
            CustomInput(
              hintText: 'Dirección',
              controller: restaurantAddressController,
              prefixIcon: Icons.storefront_rounded,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              validator: ( value ) {
                if( value.isEmpty ) {
                  return 'Debe ingresar su nombre';
                }
                return null;
              },
            ),
            SizedBox( height: 20,),
            CustomInput(
              hintText: 'Propietario',
              controller: restaurantOwnerNameController,
              prefixIcon: Icons.storefront_rounded,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              validator: ( value ) {
                if( value.isEmpty ) {
                  return 'Debe ingresar su nombre';
                }
                return null;
              },
            ),
            SizedBox( height: 20,),
            CustomInput(
              hintText: 'CLABE Interbancaria',
              controller: restaurantOwnerNameController,
              prefixIcon: Icons.account_balance_wallet_outlined,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              validator: ( value ) {
                if( value.isEmpty ) {
                  return 'Debe ingresar su nombre';
                }
                return null;
              },
            ),
            SizedBox( height: 20,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all( 2 ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular( 10 ),
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
                    controller: restaurantPhoneController,
                  )
                ),
              ],
            ),
            SizedBox( height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildLogoIput(size),
                buildCoverIput(size)
              ],
            )
          ],
        )
      ),
    );
  }

  Widget buildLogoIput( Size size ) {
    return DottedBorder(
      color: Color(0xffEFEFEF),
      strokeWidth: 3,
      radius: Radius.circular( 13 ),
      borderType: BorderType.RRect,
      dashPattern: [ 10, 4],
      padding: EdgeInsets.all(7),
      child: Tooltip(
        verticalOffset: 50,
        message: 'Seleccionar logotipo',
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            showImageOptions(
              context,
              Container(
                // padding: EdgeInsets.only(),
                child: Column(
                  children: [
                    CustomButton(
                      backgroundColor: Colors.white,
                      text: 'Tomar una foto',
                      textColor: Colors.black,
                      fontSize: 15,
                      onPressed: () {
                        print('Tomar foto');
                      },
                    ),
                    CustomButton(
                      backgroundColor: Colors.white,
                      text: 'Seleccionar de galeria',
                      textColor: Colors.black,
                      fontSize: 15,
                      onPressed: () {
                        print('Galeria');
                      },
                    ),
                  ],
                )
              ),
              () {
                Navigator.of(context).pop();
              }
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffEFEFEF),
              borderRadius: BorderRadius.circular(13),
            ),
            width: size.width * 0.40,
            height: size.height * 0.10,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon( Icons.add_photo_alternate_outlined, color: Colors.grey),
                  SizedBox( height:5),
                  Text( 'Seleccionar logotipo', style: TextStyle( fontSize: 13, color: Colors.grey ), textAlign: TextAlign.center, ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCoverIput( Size size ) {
    return DottedBorder(
      color: Color(0xffEFEFEF),
      strokeWidth: 3,
      radius: Radius.circular( 13 ),
      borderType: BorderType.RRect,
      dashPattern: [ 10, 4],
      padding: EdgeInsets.all(7),
      child: Tooltip(
        verticalOffset: 50,
        message: 'Seleccionar portada',
        child: GestureDetector(
          onTap: () {
            print('xd');
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffEFEFEF),
              borderRadius: BorderRadius.circular(13),
            ),
            width: size.width * 0.40,
            height: size.height * 0.10,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon( Icons.add_photo_alternate_outlined, color: Colors.grey),
                  SizedBox( height:5),
                  Text( 'Seleccionar portada', style: TextStyle( fontSize: 13, color: Colors.grey ), textAlign: TextAlign.center, ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
