import 'package:MyApp/core/models/agency.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:strings/strings.dart';
import './employee_image.dart';

class EmployeeListTile extends StatelessWidget {

  final Employee employee;
  final Agency agency;

  EmployeeListTile({@required this.employee, this.agency});

  @override
  Widget build(BuildContext context) {

    String agencyName = agency != null ? agency?.name : " "; 

    return ListTile(
      leading: EmployeeImage(imageUrl: employee.imageUrl),
      title: Text(
          capitalize("${employee?.firstName}") + " " + capitalize("${employee?.lastName}"),
          style: TextStyle(color: Colors.black, fontFamily: "Times")),
      subtitle: Text("$agencyName",style: TextStyle(fontFamily: "Times"),),
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
            context, '/Profil', ModalRoute.withName("/Home"),
            arguments: employee?.id);
      },
    );
  }
}
