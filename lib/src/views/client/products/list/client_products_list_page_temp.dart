import 'package:en_corto/src/models/menu_item.dart';
import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/views/client/products/list/menu_page.dart';
import 'package:en_corto/src/views/client/products/list/products_list_page.dart';
import 'package:en_corto/src/views/general/account_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';


class ClientProductsListPageTemp extends StatefulWidget {

  @override
  _ClientProductsListPageTempState createState() => _ClientProductsListPageTempState();
}

class _ClientProductsListPageTempState extends State<ClientProductsListPageTemp> {

  MenuItem currentItem = MenuItems.home;

  @override
  Widget build(BuildContext context) => ZoomDrawer(
    style: DrawerStyle.Style1,
    slideWidth: MediaQuery.of(context).size.width * 0.7,
    backgroundColor: nixEnCortoPrimaryColor.withGreen(180),
    angle: 0,
    showShadow: true,
    disableGesture: true,
    mainScreen: getScreen(),
    menuScreen: Builder(
      builder: (context) => MenuPage(
        currentItem: currentItem,
        onSelectedItem: (item) {
          setState(() => currentItem = item );
          ZoomDrawer.of(context).close();
        }
      ),
    ),
  );

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.home:
        return ProductsListPage();
      case MenuItems.settings:
        return AccountSettingsPage();
      case MenuItems.orders:
        return ProductsListPage();
      case MenuItems.role:
        return ProductsListPage();
      default:
        return ProductsListPage();
    }
  }
}