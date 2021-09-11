import 'package:en_corto/src/theme/constants.dart';
import 'package:en_corto/src/views/client/products/list/client_products_list_page.dart';
import 'package:en_corto/src/views/general/account_settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class ClientNavigationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0 );

    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: nixEnCortoMutedColor,
              offset: Offset( 0, 8),
              blurRadius: 10
            )
          ]
          // border: Border(top: BorderSide( width: 0.2, color: nixEnCortoMutedColor),)
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property.
    );

  }

  List<Widget> _buildScreens() {
      return [
        ClientProductsListPage(),
        ClientProductsListPage(),
        ClientProductsListPage(),
        AccountSettingsPage(),
      ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
            icon: FaIcon( CupertinoIcons.house, size: 20),
            title: ("Inicio"),
            activeColorPrimary: Colors.transparent, //Background Color
            activeColorSecondary: nixEnCortoPrimaryColor, //Icon and Text Color
            inactiveColorPrimary: nixEnCortoMutedColor,
        ),
        PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.shopping_cart, size: 20),
            title: ("Carrito"),
            activeColorPrimary: Colors.transparent, //Background Color
            activeColorSecondary: nixEnCortoPrimaryColor, //Icon and Text Color
            inactiveColorPrimary: nixEnCortoMutedColor,
        ),
        PersistentBottomNavBarItem(
            icon: FaIcon( FontAwesomeIcons.search, size: 18),
            title: ("Buscar"),
            activeColorPrimary: Colors.transparent, //Background Color
            activeColorSecondary: nixEnCortoPrimaryColor, //Icon and Text Color
            inactiveColorPrimary: nixEnCortoMutedColor,
        ),
          PersistentBottomNavBarItem(
            icon: Icon(FontAwesomeIcons.cog, size: 18),
            title: ("Ajustes"),
            activeColorPrimary: Colors.transparent, //Background Color
            activeColorSecondary: nixEnCortoPrimaryColor, //Icon and Text Color
            inactiveColorPrimary: nixEnCortoMutedColor,
            inactiveColorSecondary: Colors.transparent
        ),
    ];
  }
}