import 'package:en_corto/src/models/user.dart';
import 'package:en_corto/src/services/auth_service.dart';
import 'package:en_corto/src/theme/constants.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                height: size.width * 0.13,
                width: size.width * 0.13,
                child: _buildImage(user)),
          ),
          SizedBox( height: 10,),
          Text('${user.name} ${user.lastname}', style: TextStyle( fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis,),
          SizedBox( height: 20,),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.clipboard,
                  size: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Ordenes',
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
              ],
            ),
            onTap: () {},
          ),
          SizedBox( height: 10,),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              children: [
                Icon( Icons.account_balance_wallet_outlined, size: 20),
                SizedBox(
                  width: 6,
                ),
                Text('Billetera',
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
              ],
            ),
            onTap: () {},
          ),
          SizedBox( height: 10,),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.commentAlt,
                  size: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Mensajes',
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
              ],
            ),
            onTap: () {},
          ),
          SizedBox( height: 10,),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              children: [
                FaIcon(
                  Icons.settings_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Ajustes',
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
              ],
            ),
            onTap: () {},
          ),
          SizedBox( height: 20,),
          Divider(
            color: nixEnCortoMutedColor
          ),
          SizedBox( height: 20,),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.heart,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Favoritos',
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
              ],
            ),
            onTap: () {},
          ),
          SizedBox( height: 10,),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.headphonesAlt,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Ayuda',
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
              ],
            ),
            onTap: () {},
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
}
