
import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/widgets/clien_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;


class ClientProductsListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      drawer: ClientNavigationDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: ( context ) => _buildMenu( context ),
        ),
        title: Container(
          width: size.width * 0.45,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: Container(child: Text('Calle Hidalgo 434 Centro', overflow: TextOverflow.clip,style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300)))),
              SizedBox( width: 5),
              FaIcon( FontAwesomeIcons.chevronDown, size: 12, color: nixEnCortoMutedColor)
            ],
          ),
        )
      ),
      body: Center(
        child: Text('Hola productos'),
     ),
   );
  }

  Widget _buildMenu( BuildContext context ) {
    return IconButton(
      icon: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: Image.asset('assets/img/general/menu.png', width: 17, height: 17)
      ),
      onPressed: () => Scaffold.of(context).openDrawer()
    );
  }
}