import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('assets/img/icons/arrow_left.png', width: 20),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}