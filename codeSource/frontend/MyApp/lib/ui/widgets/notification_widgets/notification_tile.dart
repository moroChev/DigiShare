import 'package:flutter/material.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:strings/strings.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_image.dart';

class NotificationTile extends StatelessWidget {
   
   final Employee employee;
   final String text;

  NotificationTile({@required this.employee,@required this.text});

  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: EmployeeImage(imageUrl: employee.imageUrl),
      title: Text(
          capitalize("${employee?.firstName}") + " " + capitalize("${employee?.lastName}"),
          style: TextStyle(color: Colors.black, fontFamily: "Times")),
      subtitle: Text("$text",style: TextStyle(fontFamily: "Times"),),
      onTap: () {
  /*       Navigator.pushNamedAndRemoveUntil(
            context, '/Profil', ModalRoute.withName("/Home"),
            arguments: employee?.id); */
      },
    );
  }
}