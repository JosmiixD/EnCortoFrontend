import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:en_corto/src/helpers/helpers.dart';
import 'package:en_corto/src/models/user.dart';
import 'package:en_corto/src/services/auth_service.dart';
import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/widgets/custom_button.dart';
import 'package:en_corto/src/widgets/custom_hamburger_menu.dart';
import 'package:en_corto/src/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';



class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: MenuWidget(),
        title: Text('Mi perfil')
      ),
      body: Container(
        padding: EdgeInsets.symmetric( horizontal: 20, vertical: 5),
        child: _Form(),
      )
   );
  }
}

class _Form extends StatefulWidget {
  const _Form({
    Key key,
  }) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nameController      = TextEditingController();
  final lastNameController  = TextEditingController();
  final phoneController     = TextEditingController();
  File profileImage;

  @override
  void initState() { 
    User user = Provider.of<AuthService>(context, listen: false).user;
    nameController.text = user.name;
    lastNameController.text = user.lastname;
    phoneController.text = user.phone;
    print('Profile InitState');
    super.initState();
  }

  @override
  void dispose() { 
    nameController?.dispose();
    lastNameController?.dispose();
    phoneController?.dispose();
    print('Profile Dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);
    final User user = authService.user;
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric( horizontal: 20),
          width: size.width,
          child: Column(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: size.width * 0.35,
                      width: size.width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular( (size.width * 0.35)/2 )
                      ),
                      child: _buildImage(user)
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        height: size.width * 0.08,
                        width: size.width * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular( size.width * 0.04 ),
                          color: nixEnCortoPrimaryColor
                        ),
                        child: Center(child: FaIcon( FontAwesomeIcons.camera, size: size.width * 0.03, color: Colors.white))
                      )
                    )
                  ],
                ),
                onTap: (){
                  showOptions( context, 
                    onCameraPressed: () {
                      _selectImage( ImageSource.camera );
                    },
                    onGalleryPressed: () {
                      _selectImage( ImageSource.gallery );
                    },
                  );
                }
              ),
              SizedBox( height: 20),
              Text('${user.name} ${user.lastname}', style: TextStyle( fontSize: 15,fontWeight: FontWeight.w500,)),
              Text('${user.email}', style: TextStyle( fontSize: 13,fontWeight: FontWeight.w400, color: nixEnCortoMutedColor)),
              SizedBox( height: 30 ),
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
                hintText: 'Numero de telefono',
                prefixIcon: FontAwesomeIcons.mobileAlt,
                controller: phoneController,
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        )
      ],
    );
  }


  _selectImage( ImageSource source ) async {

    try {
      
      final ImagePicker _imagePicker = ImagePicker();

      XFile pickedImage = await _imagePicker.pickImage(source: source, imageQuality: source == ImageSource.camera ? 50 : 70 );

      if( pickedImage != null ) {

        profileImage = File( pickedImage.path );
        Navigator.pop(context);
        setState(() {});

      }

    } catch (e) {
      showAlert(context, FontAwesomeIcons.exclamationCircle, nixEnCortoDangerColor, 'Error', '$e' );
    }

  }


  _buildImage(User user) {

    return ( user.image != null && profileImage == null )
    ? FadeInImage(
      placeholder: AssetImage('assets/img/general/loading.gif'),
      image: NetworkImage( user.image ),
      fit: BoxFit.cover
    )
    : ClipOval(
      child: Image(
        image: profileImage != null ? FileImage( profileImage ) : AssetImage('assets/img/general/default_profile_picture.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  showOptions( BuildContext context, {VoidCallback onCameraPressed, VoidCallback onGalleryPressed} ) {
    showDialog(
      barrierColor: Colors.black38, 
      context: context,
      builder: ( _ ) => ElasticIn(
        child: OptionsAlertDialog(
          onCameraPressed: onCameraPressed,
          onGalleryPressed: onGalleryPressed,
        ),
      )
    );
  }
}

class OptionsAlertDialog extends StatelessWidget {

  final VoidCallback onCameraPressed;
  final VoidCallback onGalleryPressed;

  const OptionsAlertDialog({Key key, @required this.onCameraPressed, @required this.onGalleryPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular( 20 )
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: size.height * 0.40,
        width: size.width * 0.80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular( 20 )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              width: size.width * 0.80,
              height: size.height * 0.18,
              child: SvgPicture.asset('assets/img/general/svg/camera.svg', fit: BoxFit.cover)
            ),
            // SizedBox( height: 8 ),
            Container(
              width: size.width * 0.80,
              child: Text('Seleccione como desea agregar su fotografia' ,textAlign: TextAlign.center,)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.35,
                  height: 45,
                  child: CustomButton(
                    backgroundColor: nixEnCortoPrimaryColor,
                    text: 'Camara',
                    icon: FontAwesomeIcons.camera,
                    iconSize: 18,
                    fontSize: 15,
                    onPressed: this.onCameraPressed
                  ),
                ),
                SizedBox( width: 5 ),
                Container(
                  width: size.width * 0.35,
                  height: 45,
                  child: CustomButton(
                    backgroundColor: nixEnCortoSecondaryColor,
                    text: 'Galeria',
                    fontSize: 15,
                    icon: FontAwesomeIcons.image,
                    iconSize: 20,
                    onPressed: this.onGalleryPressed
                  ),
                ),
              ],
            ),
            SizedBox()
          ],
        )
      ),
    ); 

  }
}