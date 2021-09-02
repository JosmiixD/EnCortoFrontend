import 'package:en_corto/src/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {

  final Color backgroundColor;
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  final double fontSize;
  final IconData icon;
  final double radius;
  final double elevation;

  const CustomButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.backgroundColor = nixEnCortoPrimaryColor,
    this.fontSize = 10.0,
    this.textColor = Colors.white,
    this.icon,
    this.radius = 10,
    this.elevation = 3
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressed,
      style: ElevatedButton.styleFrom(
        elevation: this.elevation,
        primary: this.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( this.radius )
        )
      ),
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if( this.icon != null )
              ...[
                FaIcon( this.icon, size: this.fontSize * 2 ),
                SizedBox( width: 5 )
              ],
              Text( this.text, style: TextStyle( color: this.textColor ),),
            ],
          ),
        )
      ),
    );
  }
}