import 'package:MyApp/Screens/AgencyScreen.dart';
import 'package:flutter/material.dart';
import 'Screens/SignInScreen.dart';
import 'Screens/Profil.dart';
import 'Screens/Home.dart';
import 'Screens/ToPostScreen.dart';
import 'InheritedWidgets/UserModel.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return UserModel(
          child: MaterialApp(
              title: 'Sign Up Screen ',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.teal,
                textTheme: TextTheme(body1: TextStyle(fontFamily: "Times")),
              ),
              initialRoute: 'SignIn',
                routes: {
                  'SignIn'          :(context)=>SignInScreen(),
                  'Profil'          :(context)=>Profil(employeeID: ModalRoute.of(context).settings.arguments,),
                  'Home'            :(context)=>Home(),
                  'ToPostScreen'    :(context)=>ToPostScreen(),
                  'Agency'          :(context)=>AgencyScreen(agencyId: ModalRoute.of(context).settings.arguments),
                  
                },
      ),

    );
  }
}
