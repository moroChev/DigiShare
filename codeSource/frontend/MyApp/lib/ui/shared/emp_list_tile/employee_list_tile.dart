import 'package:MyApp/core/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:strings/strings.dart';
import './employee_image.dart';

class EmployeeListTile extends StatelessWidget {
  final Employee employee;
  final String subtitle;
  final Widget trailing;
  final Function onTap;
  const EmployeeListTile({@required this.employee, this.subtitle, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: EmployeeImage(imageUrl: employee.imageUrl),
      title: Text(
          capitalize("${employee?.firstName}") + " " + capitalize("${employee?.lastName}"),
          style: TextStyle(color: Colors.black, fontFamily: "Times")),
      subtitle: subtitle == null ? Container() : Text(subtitle),
      trailing: trailing == null ? Text(" ") : trailing,
      onTap: onTap == null ? (){} : () => onTap() ,
    );
  }
}
