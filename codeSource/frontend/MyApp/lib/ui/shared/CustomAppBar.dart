import 'package:flutter/material.dart';
import './searchBar.dart';


class CustomAppBar  {
  


  static logout(BuildContext context){
   // AuthController.attemptLogOut();
    Navigator.pushNamedAndRemoveUntil(context, '/SignIn', (Route<dynamic> route) => false);
  }
  
  static Widget getAppBar(BuildContext context) {
    return AppBar(
            
        backgroundColor: Color(0xFFCFD8DC),
        actions: <Widget>[
        /*****************************************************************************************/ 
        /* this widget is representing by the search icon which is an IconButton                */
        /* this button is in his onPressed propriety has showSearch method                     */
        /* this method in turn takes context and delegate as arguments                        */
        /* the delegate argument takes a class that extends the SearchDelegate abstract class*/ 
           SearchBar(),
        /***********************************************************************************/ 
     
        ],
        );


  }
}
















