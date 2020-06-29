import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/ui/shared/decorated_logo.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';



class ProfilHeader extends StatelessWidget {

  final Employee employee;

  ProfilHeader({@required this.employee});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: AspectRatio(
        aspectRatio: 5 / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Farm logo
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                elevation: 15.0,
                color: Colors.white,
                child: DecoratedLogo(imageUrl: employee.imageUrl),
              ),
            ),
            //SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(capitalize(employee.firstName)+" "+capitalize(employee.lastName),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0,fontFamily: "Times"),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(capitalize(employee.position),style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0,fontFamily: "Times"),),
                ],
              ),
          ],
        ),
      ),
    );
  }
}