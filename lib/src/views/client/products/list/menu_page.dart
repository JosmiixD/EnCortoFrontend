import 'package:en_corto/src/models/menu_item.dart';
import 'package:en_corto/src/models/user.dart';
import 'package:en_corto/src/services/auth_service.dart';
import 'package:en_corto/src/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MenuItems {
  static const home     = MenuItem('Inicio', FontAwesomeIcons.home);
  static const profile  = MenuItem('Perfil', FontAwesomeIcons.userAlt);
  static const orders   = MenuItem('Ordenes', FontAwesomeIcons.shoppingBag);
  static const role     = MenuItem('Seleccionar rol', FontAwesomeIcons.thLarge);

  static const all = <MenuItem>[
    home,
    profile,
    orders,
    role,
  ];
}

class MenuPage extends StatelessWidget {

  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuPage({
    Key key,
    @required this.currentItem,
    @required this.onSelectedItem,
  });

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final User user = authService.user;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: nixEnCortoPrimaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox( height: 30 ),
            ListTile(
              minLeadingWidth: 20,
              leading: Container(
                width: size.width / 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: size.width * 0.10,
                      width: size.width * 0.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular( (size.width * 0.10)/2 )
                      ),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage('assets/img/general/loading.gif'),
                        image: user.image != null
                        ? Image.network(user.image)
                        : AssetImage('assets/img/general/default_profile_picture.png'),
                      )
                    ),
                    SizedBox( width: 8 ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( '${user.name}', style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white), overflow: TextOverflow.ellipsis,),
                          Text( '${user.email}', style: TextStyle(  fontSize: 12,color: Colors.white.withOpacity(0.70)), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            ...MenuItems.all.map( buildMenuItem ).toList(),
            ListTile(
              minLeadingWidth: 20,
              leading: Icon( FontAwesomeIcons.users, size: 18, color: Colors.white ),
              title: Text( "Acerca de nosotros", style: TextStyle( color: Colors.white, fontSize: 15), ),
            ),
            ListTile(
              minLeadingWidth: 20,
              leading: Icon( FontAwesomeIcons.solidThumbsUp, size: 18, color: Colors.white ),
              title: Text( "Calificanos", style: TextStyle( color: Colors.white, fontSize: 15), ),
            ),
            ListTile(
              minLeadingWidth: 20,
              leading: Icon( FontAwesomeIcons.solidQuestionCircle, size: 18, color: Colors.white ),
              title: Text( "Ayuda", style: TextStyle( color: Colors.white, fontSize: 15), ),
            ),
            Spacer( flex: 2),
            GestureDetector(
              onTap: () async {
                await authService.logout();
                Navigator.pushNamedAndRemoveUntil(context, 'loading', (route) => false);
              },
              child: ListTile(
                minLeadingWidth: 20,
                leading: Icon( Icons.logout, size: 18, color: Colors.white ),
                title: Text( "Cerrar sesión", style: TextStyle( color: Colors.white, fontSize: 15), ),
              ),
            ),
            SizedBox( height: 10 )
          ],
        )
      )
    );
  }

  Widget buildMenuItem( MenuItem item ) => ListTile(
    selected: currentItem == item,
    minLeadingWidth: 20,
    leading: Icon( item.icon, size: 18, color: currentItem == item ? nixEnCortoSecondaryColor : Colors.white ),
    title: Text( item.title, style: TextStyle( color: currentItem == item ? nixEnCortoSecondaryColor : Colors.white, fontSize: 15, fontWeight: currentItem == item ? FontWeight.w600 : FontWeight.normal), ),
    onTap: () => onSelectedItem( item ),
  );
}