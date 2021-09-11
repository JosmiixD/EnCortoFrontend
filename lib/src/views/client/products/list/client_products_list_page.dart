import 'package:en_corto/src/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ClientProductsListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            FaIcon( Icons.location_on_outlined, size: 25, color: nixEnCortoPrimaryColor),
            SizedBox( width: 10 ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Entregar en'),
                    SizedBox( width: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: FaIcon( FontAwesomeIcons.chevronDown, size: 12, color: nixEnCortoMutedColor),
                    )
                  ],
                ),
                Text('Calle Hidalgo #434 Centro Altepexi, Pue', style: nixEnCortoCaptionStyle, overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        )
      ),
      body: Center(
        child: Text('Hola productos'),
     ),
   );
  }
}