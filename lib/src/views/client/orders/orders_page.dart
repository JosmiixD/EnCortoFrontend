import 'package:en_corto/src/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class ClientOrdersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
      ),
      body: Center(
        child: Text('Orders Page'),
      ),
    );
  }
}