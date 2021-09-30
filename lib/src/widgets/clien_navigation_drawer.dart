import 'package:en_corto/src/models/user.dart';
import 'package:en_corto/src/services/auth_service.dart';
import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/views/client/messages/messages_page.dart';
import 'package:en_corto/src/views/client/orders/orders_page.dart';
import 'package:en_corto/src/views/client/wallet/wallet_page.dart';
import 'package:en_corto/src/views/general/account_settings_page.dart';
import 'package:en_corto/src/views/restaurant/register/register_as_restaurant_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ClientNavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final User user = Provider.of<AuthService>(context).user;

    return Container(
      width: size.width * 0.55,
      child: Drawer(
          child: Material(
              child: ListView(
        // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only( left: 20 ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  height: size.width * 0.13,
                  width: size.width * 0.13,
                  child: _buildImage(user)),
            ),
          ),
          SizedBox( height: 10,),
          Padding(
            padding: const EdgeInsets.only( left: 20),
            child: Text('${user.name} ${user.lastname}', style: TextStyle( fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis,),
          ),
          SizedBox( height: 20,),
          buildMenuItem(
            title: 'Ordenes',
            icon: FontAwesomeIcons.clipboard,
            iconSize: 18,
            onTap: () => selectedItem(context, 0)
          ),
          SizedBox( height: 10,),
          buildMenuItem(
            title: 'Billetera',
            icon: Icons.account_balance_wallet_outlined,
            onTap: () => selectedItem(context, 1)
          ),
          SizedBox( height: 10,),
          buildMenuItem(
            title: 'Mensajes',
            icon: FontAwesomeIcons.commentAlt,
            iconSize: 16,
            onTap: () => selectedItem(context, 2)
          ),
          SizedBox( height: 10,),
          buildMenuItem(
            title: 'Ajustes',
            icon: Icons.settings_outlined,
            onTap: () => selectedItem(context, 3)
          ),
          if( user.roles.length == 1 )
          ...[
            SizedBox( height: 10,),
            buildMenuItem(
              title: 'Negocio',
              icon: Icons.storefront_rounded,
              onTap: () => selectedItem(context, 4)
            ),
          ] else ...[
            SizedBox( height: 10,),
            buildMenuItem(
              title: 'Cambiar rol',
              icon: Icons.sync_alt_rounded,
              onTap: () => selectedItem(context, 5)
            ),
          ],
          SizedBox( height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 18),
            child: Divider(
              color: nixEnCortoMutedColor
            ),
          ),
          SizedBox( height: 20,),
          buildMenuItem(
            title: 'Favoritos',
            icon: FontAwesomeIcons.heart,
            onTap: () => selectedItem(context, 6)
          ),
          SizedBox( height: 10,),
          buildMenuItem(
            title: 'Ayuda',
            icon: FontAwesomeIcons.headphonesAlt,
            onTap: () => selectedItem(context, 7)
          ),
        ],
      ))),
    );
  }


  Widget _buildImage( User user ) {

    return ClipOval(
      child: FadeInImage(
        placeholder: AssetImage('assets/img/general/default_profile_picture.png', ),
        image: NetworkImage( '${user.image}' ),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildMenuItem( {
    @required String title,
    @required IconData icon,
    @required VoidCallback onTap,
    double iconSize = 20,
  }) {

    return ListTile(
      contentPadding: EdgeInsets.symmetric( horizontal: 20),
      title: Row(
        children: [
          FaIcon(
            icon,
            size: iconSize,
          ),
          SizedBox(
            width: 10,
          ),
          Text( title,
              style:
                  TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
        ],
      ),
      onTap: onTap,
    );
  }

  void selectedItem( BuildContext context, int index ) {

    Navigator.of(context).pop();

    switch ( index ) {
      case 0:
        Navigator.of(context).push(CupertinoPageRoute(
          builder: ( context ) => ClientOrdersPage()
        ));
        break;
      case 1:
        Navigator.of(context).push(CupertinoPageRoute(
          builder: ( context ) => ClientWalletPage()
        ));
        break;
      case 2:
        Navigator.of(context).push(CupertinoPageRoute(
          builder: ( context ) => ClientMessagesPage()
        ));
        break;
      case 3:
        Navigator.of(context).push(CupertinoPageRoute(
          builder: ( context ) => AccountSettingsPage()
        ));
        break;
      case 4:
        Navigator.of(context).push(CupertinoPageRoute(
          builder: ( context ) => RegisterMyRestaurant()
        ));
        break;
      case 5:
        Navigator.of(context).pushNamedAndRemoveUntil('roles', (route) => false);
        break;

    }

  }
}
