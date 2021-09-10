import 'package:animate_do/animate_do.dart';
import 'package:en_corto/src/models/role.dart';
import 'package:en_corto/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RolesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final user = Provider.of<AuthService>(context).user;

    return Scaffold(
        body: SafeArea(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text('Selecciona como desea ingresar',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: user.roles.length,
                  itemBuilder: ( _ , int index) {
                    return BounceInLeft(
                      delay: Duration( milliseconds: index * 200 ),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, user.roles[index].route);
                          Navigator.pushNamedAndRemoveUntil(context, user.roles[index].route, (route) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: RoleCard(
                            role: user.roles[index],
                            colors: <Color>[
                                Color(0xFFF2FEFE),
                                Color(0xFFDAFCFE),
                              ]
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    ));
  }
}

class RoleCard extends StatelessWidget {
  const RoleCard({
    Key key,
    @required this.role,
    @required this.colors,
  }) : super(key: key);

  final Role role;
  final List<Color>colors;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.20,
        width: size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: this.colors
            ),
            borderRadius: BorderRadius.all(Radius.circular(13))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric( horizontal: 5, vertical: 5 ),
              width: size.width * 0.50,
                child: SvgPicture.asset(
                    this.role.image,
                    fit: BoxFit.fitHeight,
                )),
            SizedBox(width: 5,),
            Expanded(
              child: Text(this.role.name, style: TextStyle( fontSize: 18,fontWeight: FontWeight.w600,))
            )
          ],
        ));
  }
}
