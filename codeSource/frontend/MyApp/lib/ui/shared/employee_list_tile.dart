import 'package:MyApp/core/models/employee.dart';
import 'file:///C:/Users/Hp/Desktop/My-app/codeSource/frontend/MyApp/lib/ui/shared/employee_image.dart';
import 'package:flutter/material.dart';
import '../../Screens/Profil.dart';
import 'package:flutter/cupertino.dart';
import 'package:strings/strings.dart';

class EmployeeListTile extends StatelessWidget {
  final Employee employee;
  final String subtitle;
  final Widget trailing;
  final Function onTap;
  EmployeeListTile({@required this.employee, this.subtitle, this.trailing, this.onTap});

  // just reminder
  // things to take in consideration :
  // 1) about the button in the right (more icon)
  //    a) modify option must appear only for the post owner (userId = publication.postedBy.id)
  //    b) delete option must appear only for the post owner                  ..
  //    c) approuve option must appear only for the user who have canApprouve=true field of the employee class
  //    d) dispear option can be offered to evrybody
  //    .
  //    .
  //    .
  //    i think i am going to need two employee listTiles one for posts only and one generic to display generic infos which are fullname and agency name

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: EmployeeImage(imageUrl: employee.imageUrl),
      title: Text(
          capitalize("${employee?.firstName}") + " " + capitalize("${employee?.lastName}"),
          style: TextStyle(color: Colors.black, fontFamily: "Times")),
      subtitle: subtitle == null ? Container() : Text(subtitle),
      trailing: trailing == null ? Text(" ") : trailing,
      onTap: onTap == null ? (){} : () => onTap() /*{
        Navigator.pushNamedAndRemoveUntil(
            context, '/Profile', ModalRoute.withName("/Home"),
            arguments: employee?.id);
      }*/,
    );
  }
}
