import 'package:en_corto/src/views/client/navigation_page.dart';
import 'package:en_corto/src/views/client/products/list/client_products_list_page.dart';
import 'package:en_corto/src/views/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:en_corto/src/views/general/account_settings_page.dart';
import 'package:en_corto/src/views/general/profile_page.dart';
import 'package:en_corto/src/views/introduction/introduction_screens.dart';
import 'package:en_corto/src/views/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:en_corto/src/views/roles/roles_pages.dart';
import 'package:en_corto/src/views/signup/loading_page.dart';
import 'package:en_corto/src/views/signup/login_page.dart';
import 'package:en_corto/src/views/signup/phone_number_page.dart';
import 'package:en_corto/src/views/signup/signup_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function( BuildContext )> appRoutes = {
  'loading'                 : ( _ ) => LoadingPage(),
  'introduction'            : ( _ ) => IntroductionScreens(),
  'login'                   : ( _ ) => LoginPage(),
  'signup'                  : ( _ ) => SignUpPage(),
  'phone'                   : ( _ ) => PhoneNumberPage(),
  'roles'                   : ( _ ) => RolesPage(),
  'profile'                 : ( _ ) => ProfilePage(),
  'account/settings'        : ( _ ) => AccountSettingsPage(),
  'client/navigation'       : ( _ ) => ClientNavigationPage(),

  'client/products/list'    : ( _ ) => ClientProductsListPage(),
  'restaurant/orders/list'  : ( _ ) => RestaurantOrdersListPage(),
  'delivery/orders/list'    : ( _ ) => DeliveryOrdersListPage(),
};