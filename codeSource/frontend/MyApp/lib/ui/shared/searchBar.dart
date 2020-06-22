import 'package:flutter/material.dart';
import 'package:MyApp/core/services/Search_emp_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SearchBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.searchengin),
      color: Colors.black45,
      hoverColor: Colors.red[200],  
      onPressed: (){
        showSearch(context: context, delegate: SearchEmployee());
        print("icon button is pressed ! ");
      }
      );
  }


}