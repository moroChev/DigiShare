import 'package:flutter/material.dart';
import '../Search/searchBar.dart';


class CustomAppBar  {
  

  
  static Widget getAppBar(BuildContext context) {
    return AppBar(
       /*  leading: GestureDetector(
        child: Icon(Icons.menu,),
         onTap: () {  Navigator.pop(context);
                      Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SideMenuWidget()));
                       },
  ),   */
        
        backgroundColor: Color(0xFFCFD8DC),
        actions: <Widget>[
        /*****************************************************************************************/ 
        /* this widget is representing by the search icon which is an IconButton                */
        /* this button is in his onPressed propriety has showSearch method                     */
        /* this method in turn takes context and delegate as arguments                        */
        /* the delegate argument takes a class that extends the SearchDelegate abstract class*/ 
           SearchBar(),
        /***********************************************************************************/ 
           
      
     /*      Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(    
          child: Icon( Icons.more_vert),
           onTap: () { Navigator.pop(context);
                      Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SignInScreen()));
                      },
        )
      ), */
        ],
        );

  }
}
















