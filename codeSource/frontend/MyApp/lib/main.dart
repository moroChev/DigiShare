import 'package:MyApp/Screens/AgencyScreen.dart';
import 'package:flutter/material.dart';
import 'Screens/SignInScreen.dart';
import 'Screens/Profil.dart';
import 'Screens/Home.dart';
import 'Screens/SplashScreen.dart';
import 'Screens/ToPostScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
     initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/SignIn': (context) => SignInScreen(),
        '/Home': (context) => Home(),
        '/Profil': (context) => Profil(employeeID: ModalRoute.of(context).settings.arguments),
        '/Agency': (context) => AgencyScreen(agencyId: ModalRoute.of(context).settings.arguments),
        '/ToPostScreen': (context) => ToPostScreen(),
      },
    );
  }
}
