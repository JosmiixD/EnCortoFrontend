import 'package:en_corto/src/services/auth_service.dart';
import 'package:en_corto/src/views/general/profile_page.dart';
import 'package:en_corto/src/views/signup/loading_page.dart';
import 'package:en_corto/src/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';


class AccountSettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text('Configuración'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric( horizontal: 15),
          margin: EdgeInsets.only( top: 20 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cuenta',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              CustomListTile(
                leadingWidget: FaIcon( FontAwesomeIcons.user, size: 18),
                title: "Información del perfil",
                subtitle: "Cambia la información de tu cuenta",
                onTap: () {
                  pushNewScreen(
                      context,
                      screen: ProfilePage(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
              CustomListTile(
                leadingWidget: FaIcon( FontAwesomeIcons.creditCard, size: 18),
                title: "Metodos de pago",
                subtitle: "Añada sus tarjetas de credito o debito",
                onTap: () {
                  Navigator.of(context).pushNamed('profile');
                },
              ),
              CustomListTile(
                leadingWidget: FaIcon( Icons.room_outlined, size: 25),
                title: "Direcciones",
                subtitle: "Añada sus direcciones de entrega",
                onTap: () {
                  Navigator.of(context).pushNamed('profile');
                },
              ),
              CustomListTile(
                leadingWidget: FaIcon( FontAwesomeIcons.shareAlt, size: 19),
                title: "Invita a tus amigos",
                subtitle: "Obten recompensas al invitar a tus conocidos",
                onTap: () {
                  Navigator.of(context).pushNamed('profile');
                },
              ),
              CustomListTile(
                leadingWidget: FaIcon( FontAwesomeIcons.bell, size: 19),
                title: "Notificaciones",
                subtitle: "Elige las notificaciones de tu interes",
                onTap: () {
                  Navigator.of(context).pushNamed('profile');
                },
              ),
              SizedBox( height: 30),
              Text('Más',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              SizedBox( height: 20),
              CustomListTile(
                leadingWidget: FaIcon( FontAwesomeIcons.questionCircle, size: 19),
                title: "FAQ",
                subtitle: "Preguntas frecuentes",
                onTap: () {
                  Navigator.of(context).pushNamed('profile');
                },
              ),
              SizedBox( height: 20),
              GestureDetector(
                child: ListTile(
                  minLeadingWidth: 20,
                  leading: Align(
                    widthFactor: 0.8,
                    alignment: Alignment.centerLeft,
                    child:  FaIcon( Icons.logout, size: 22),
                  ),
                  title: Text( 'Cerrar sesión', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400), ),
                ),
                onTap: () async {
                  await authService.logout();
                  Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new LoadingPage()));
                },
              ),
            ],
          ),
        )
      )
   );
  }
}

class CustomListTile extends StatelessWidget {

  final Widget leadingWidget;
  final Widget trailingWidget;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CustomListTile({
    Key key,
    @required this.leadingWidget,
    @required this.title,
    @required this.subtitle,
    @required this.onTap,
    this.trailingWidget = const FaIcon( FontAwesomeIcons.chevronRight, size: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        minLeadingWidth: 20,
        leading: Align(
          widthFactor: 0.8,
          alignment: Alignment.centerLeft,
          child:  this.leadingWidget
        ),
        title: Text( this.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), ),
        subtitle: Text( this.subtitle , style: TextStyle( fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis,),
        trailing: this.trailingWidget
      ),
      onTap: this.onTap,
    );
  }
}