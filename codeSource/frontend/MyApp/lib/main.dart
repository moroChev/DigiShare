import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'agency.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  //those variables will be passed from the main page to the constructor of the agency page
  String agencyId = /*"5ed23232da2b8b20300a571d";//"5ed12d60932dfd2328f8d6dc";*/"5ed12c96932dfd2328f8d6db";
  String secureToken =
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ZWQxMTg0ZDQyM2Q5YjA4OWNhNzBiZGUiLCJpYXQiOjE1OTA4ODU5MzgsImV4cCI6MTU5MDk3MjMzOH0.bvEvveuEhHFnbG1STrknqce0abREIMDrb8d-A0pjPxI";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AgencyPage(title: 'Leaflet Demo', agencyId: agencyId, secureToken: secureToken),
    );
  }
}