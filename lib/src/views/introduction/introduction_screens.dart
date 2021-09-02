import 'package:en_corto/src/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';


class IntroductionScreens extends StatelessWidget {


  final pages = [
    PageViewModel(
      title: "Descubre lugares cerca de ti",
      body: "Hacemos simple encontrar la comida que deseas, ingresa tu dirección y déjanos hacer el resto",
      decoration: PageDecoration(
        imageFlex: 4,
        bodyFlex: 2
      ),
      image: Container(
        child: Image.asset("assets/img/general/search_places.png", height: 250.0),
      ),
    ),
    PageViewModel(
      title: "Ordena tu comida favorita",
      body: "Elige la comida que más te gusta desde la comodidad de tu casa o donde te encuentres 🤫",
      decoration: PageDecoration(
        imageFlex: 4,
        bodyFlex: 2
      ),
      image: Container(
        child: Image.asset("assets/img/general/shop_online.png", height: 250.0),
      ),
    ),
    PageViewModel(
      title: "Entrega inmediata",
      body: "Hacemos que tu pedido este contigo lo más pronto posible, sin importar si pagas con tarjeta o en efectivo",
      decoration: PageDecoration(
        imageFlex: 4,
        bodyFlex: 2
      ),
      image: Container(
        child: Image.asset("assets/img/general/delivery_on_road.png", height: 175.0),
      ),
    ),
  ];


  void onIntroEnds( BuildContext context ) {
    Navigator.of(context).pushReplacementNamed('login');
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      color: nixEnCortoPrimaryColor,
      dotsDecorator: DotsDecorator(
        activeColor: nixEnCortoPrimaryColor,
        activeSize: Size(18.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      showNextButton: true,
      next: Text('Siguiente'),
      showSkipButton: true,
      skip: Text('Omitir', style: TextStyle( color: nixEnCortoMutedColor)),
      onSkip: () => onIntroEnds( context ),
      pages: pages,
      done: const Text('Hecho'),
      onDone: () => onIntroEnds( context ),
    );
  }
}