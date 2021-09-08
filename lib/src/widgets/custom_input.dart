import 'package:en_corto/src/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomInput extends StatefulWidget {

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final FormFieldValidator<String> validator;
  final bool isPassword;
  final int maxLines;
  final IconData prefixIcon;
  final TextStyle textStyle;
  final double prefixIconSize;
  
  const CustomInput({
    Key key,
    @required this.hintText,
    @required this.controller,
    @required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.textStyle = const TextStyle( fontSize: 16 ),
    this.maxLines = 1,
    this.prefixIconSize = 18
  }) : super(key: key);

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {

  FocusNode _focus = new FocusNode();
  bool showPassword = false;
  bool isFocused = false;

  @override
  void initState() { 
    _focus.addListener( _onFocusChange );
    super.initState();
  }

  @override
  void dispose() { 
    _focus.removeListener( _onFocusChange );
    _focus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = !isFocused;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all( 2 ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular( 10 ),
            border: Border.all(
              color: isFocused ? nixEnCortoPrimaryColor : nixEnCortoMutedColor.withOpacity(0.5)
            ),
            color: Color(0xffEFEFEF),
          ),
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        TextFormField(
          focusNode: _focus,
          maxLines: this.widget.maxLines,
          validator: this.widget.validator != null ? this.widget.validator : ( value ) {
            if( value.isEmpty ) {
              return 'Ingrese un valor al campo';
            }
            return null;
          } ,
          style: this.widget.textStyle,
          controller: this.widget.controller,
          cursorColor: nixEnCortoPrimaryColor,
          autocorrect: false,
          keyboardType: this.widget.keyboardType,
          textCapitalization: this.widget.textCapitalization,
          textInputAction: this.widget.textInputAction,
          obscureText: this.widget.isPassword ? this.showPassword ? false : true : false, 
          decoration: InputDecoration(
            suffixIcon: this.widget.isPassword ? Padding(
              padding: const EdgeInsets.only( top: 15,),
              child: InkWell( splashColor: Colors.transparent ,child: FaIcon( this.showPassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye, size: 20), onTap: () {
                setState(() {
                  this.showPassword = !this.showPassword;
                });
              }),
            ) : null,
            prefixIcon: Icon( this.widget.prefixIcon, size: this.widget.prefixIconSize,),
            hintText: this.widget.hintText,
            focusColor: nixEnCortoPrimaryColor,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            errorStyle: TextStyle(
              color: nixEnCortoDangerColor
            ),
          ),
        ),
      ],
    );
  }
}