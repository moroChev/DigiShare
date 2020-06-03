import 'package:MyApp/entities/Employee.dart';
import 'package:flutter/material.dart';

class LikesWidget extends StatefulWidget {

  List<Employee> employees;

  LikesWidget({this.employees});

  @override
  _LikesWidgetState createState() => _LikesWidgetState();
}

class _LikesWidgetState extends State<LikesWidget> {
   
  List<Employee> _employees;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}