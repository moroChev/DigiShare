import 'package:flutter/material.dart';
import 'package:MyApp/core/services/Search_emp_service.dart';


class SearchBar extends StatelessWidget {
  
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