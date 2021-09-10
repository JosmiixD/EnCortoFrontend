import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MenuWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Image.asset('assets/img/general/menu.png', width: 20, height: 20)
    ),
    onPressed: () => ZoomDrawer.of(context).toggle(),
  );
}