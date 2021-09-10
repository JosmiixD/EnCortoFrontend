import 'package:en_corto/src/widgets/custom_hamburger_menu.dart';
import 'package:flutter/material.dart';



class ProductsListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MenuWidget(),
      ),
      body: Center(
        child: Text('Hola Product List Page'),
        
     ),
   );
  }
}
