import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import '../Screens/SignInScreen.dart';
import '../Screens/SignUPScreen.dart';
import '../Screens/profil.dart';
import '../Screens/Home.dart';
import './SideMenuWidget.dart';

class CustumAppBar  {

  
 static Widget getAppBar(BuildContext context){
    return AppBar(
      leading: GestureDetector(
      child: Icon(Icons.menu,),
       onTap: () {  Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SideMenuWidget()));
                     },
  ),  
      backgroundColor: Colors.blue[50],
      actions: <Widget>[
        Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(    
        child: Icon( Icons.more_vert),
         onTap: () { Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignInScreen()));
                    },

      )
    ),
      ],);
  }
}





/* PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Colors.white, Color(0xFFF7F7FA)])),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
      
          ],
        ),
      ),
    ); */
















      /* IconButton(
              icon: Icon(Icons.menu),
              onPressed: (){
                    Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SideMenuWidget()));
                    },
            ), 
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignInScreen()));
              },
            )
            */