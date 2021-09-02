import 'package:en_corto/src/routes/routes.dart';
import 'package:en_corto/src/theme/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'En Corto',
      debugShowCheckedModeBanner: false,
      initialRoute: 'introduction',
      routes: appRoutes,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: nixEnCortoPrimaryColor,
        accentColor: nixEnCortoPrimaryColor,
        primaryTextTheme: TextTheme(
          headline6: TextStyle( color: Colors.black )
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData( color: Colors.black ),
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: ThemeData.light()
          .textTheme
          .apply( fontFamily: 'Poppins' )
      ),
    );
  }
}