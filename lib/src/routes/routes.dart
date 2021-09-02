import 'package:en_corto/src/views/introduction/introduction_page.dart';
import 'package:en_corto/src/views/introduction/introduction_screens.dart';
import 'package:en_corto/src/views/signup/login_page.dart';
import 'package:en_corto/src/views/signup/signup_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function( BuildContext )> appRoutes = {
  'introduction'          : ( _ ) => IntroductionScreens(),
  'introduction_example'  : ( _ ) => IntroductionPage(),
  'login'                 : ( _ ) => LoginPage(),
  'signup'                : ( _ ) => SignUpPage(),
};