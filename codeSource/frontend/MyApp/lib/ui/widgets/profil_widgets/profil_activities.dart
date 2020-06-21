import 'package:MyApp/core/models/employee.dart';
import 'package:flutter/material.dart';



class ProfilActivities extends StatelessWidget {

 final Employee employee;

 ProfilActivities({@required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 70.0,
    margin: EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('${employee.publicationsObjects?.length}'),
            Text("publications", style: TextStyle(fontFamily: "Times"),),
          ],
        ),
      ],
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xFFFF9F9F9),
      boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5),spreadRadius: 5,blurRadius: 7,offset: Offset(0, 3),),
        ],
      ),
  );
  }
}