import 'package:MyApp/entities/Employee.dart';
import 'package:flutter/material.dart';
import '../InheritedWidgets/InheritedUserModel.dart';


class UserModel extends StatefulWidget {

  final Widget child;
  UserModel({this.child});

  @override
  UserModelState createState() => UserModelState();

  static UserModelState of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<InheritedUserModel>().currentUserState;
  }

}

class UserModelState extends State<UserModel> {

  Employee _employee;

  Employee get employee => _employee;

  void setEmployee(Employee employee){
    setState(() {
      _employee= employee;
      print("Ia m in the User model and i am setting the employee just after the auth with success ... ");
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedUserModel(currentUserState: this, child: widget.child,);
  }
}