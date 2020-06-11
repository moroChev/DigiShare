import 'package:flutter/material.dart';
import './SearchEmployee.dart';





class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      hoverColor: Colors.red[200],  
      onPressed: (){
        showSearch(context: context, delegate: SearchEmployee());
        print("icon button is pressed ! ");
      }
      );
  }
}