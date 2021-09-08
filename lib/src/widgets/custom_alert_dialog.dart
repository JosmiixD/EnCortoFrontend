import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {

  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;

  const CustomAlertDialog({
    Key key,
    this.icon, 
    this.iconColor,
    this.title, 
    this.message,
  }) : super(key: key);


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
        height: size.height * 0.45,
        width: size.width * 0.80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular( 20 )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon( this.icon, size: 80, color: this.iconColor ),
            SizedBox( height: 20 ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text( this.title, style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  SizedBox( height: 20),
                  Text( this.message, style: TextStyle( fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black), textAlign: TextAlign.center,)
                ],
              ),
            ),
            SizedBox( height: 8 ),
            Container(
              width: size.width * 0.45,
              height: 45,
              child: CustomButton(
                backgroundColor: this.iconColor,
                text: 'Ok',
                fontSize: 15,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )

          ],
        )
      ),
    );  
  }
}