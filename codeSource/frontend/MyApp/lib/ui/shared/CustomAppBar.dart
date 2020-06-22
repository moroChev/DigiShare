import 'package:flutter/material.dart';
import './searchBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

 final double height;

  const CustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xFFF5F5F5), 
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

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

  


  static logout(BuildContext context){
   // AuthController.attemptLogOut();
    Navigator.pushNamedAndRemoveUntil(context, '/SignIn', (Route<dynamic> route) => false);
  }
  
}
















