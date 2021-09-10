import 'package:en_corto/src/routes/routes.dart';
import 'package:en_corto/src/services/auth_service.dart';
import 'package:en_corto/src/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService())
      ],
      child: MaterialApp(
        title: 'En Corto',
        debugShowCheckedModeBanner: false,
        initialRoute: 'loading',
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
            backgroundColor: Colors.white
          ),
          textTheme: ThemeData.light()
            .textTheme
            .apply( fontFamily: 'Poppins' )
        ),
      ),
    );
  }
}