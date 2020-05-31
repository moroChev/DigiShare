import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import '../Screens/SignInScreen.dart';
import '../Screens/SignUPScreen.dart';
import '../Screens/profil.dart';
import '../Screens/Home.dart';

class CustumAppBar  {

  
 static getAppBar(BuildContext context){
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Colors.white, Color(0xFFF7F7FA)])),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                    Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
                    },
            ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignInScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
