import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
        body: Stack(
          children: [
            _buildBackground(size),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Todo lo que necesitas',
                        style: TextStyle(
                            fontSize: 16, height: 1, color: nixEnCortoSecondaryColor),
                      ),
                      SizedBox( height: 5,),
                      Row(
                        children: [
                          Text(
                            'EN ',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold, height: 1, color: nixEnCortoTertiaryColor),
                          ),
                          Text(
                            'CORTO',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold, height: 1, color: nixEnCortoPrimaryColor),
                          ),
                        ],
                      ),
                      SizedBox( height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(
                          'Ordena tus alimentos de los restaurantes registrados y disfruta de ellos con el envió más rápido del mercado',
                          style: TextStyle(
                              fontSize: 12, height: 1, fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox( height: 20,),
                      Container(
                        width: size.width * 0.50,
                        height: size.height * 0.06,
                        child: CustomButton(
                          text: 'Tengo hambre',
                          radius: 30.0,
                          elevation: 0,
                          onPressed: (){
                            Navigator.of(context).pushReplacementNamed('login');
                          },
                        ),
                      ),
                      SizedBox( height: 50,),
                      Container(
                        height: size.height * 0.20,
                        width: size.width,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY( math.pi ),
                          child: Image.asset(
                            'assets/img/general/delivery_on_road.png',
                            fit: BoxFit.fill,
                          ),
                        )
                      ),
                      SizedBox( height: 100,),

                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Container _buildBackground(Size size) {
    return Container(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: size.width * -0.35,
                  child: Container(
                    height: size.width * 0.80,
                    width: size.width * 0.80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.45),
                      color: Colors.pink.withOpacity(0.06)
                    ),
                  )
                ),
                Positioned(
                  top: size.height * 0.45,
                  right: 50,
                  child: Container(
                    height: size.width * 0.15,
                    width: size.width * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.075),
                      color: nixEnCortoPrimaryColor.withOpacity(0.1)
                    ),
                  ),
                ),
                Positioned(
                  right: 40,
                  child: Container(
                    height: size.width * 0.30,
                    width: size.width * 0.30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.15),
                      color: nixEnCortoPrimaryColor.withOpacity(0.1)
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.30,
                  right: 25,
                  child: Container(
                    height: size.width * 0.10,
                    width: size.width * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.05),
                      color: Colors.pink.withOpacity(0.1)
                    ),
                  ),
                ),
                Positioned(
                  left: 40,
                  bottom: size.height * 0.30,
                  child: Container(
                    height: size.width * 0.20,
                    width: size.width * 0.20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.1),
                      color: nixEnCortoPrimaryColor.withOpacity(0.1)
                    ),
                  ),
                ),
              ]
            )
          );
  }
}
