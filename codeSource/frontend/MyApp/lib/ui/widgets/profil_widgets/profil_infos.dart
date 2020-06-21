import 'package:MyApp/core/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';



class ProfilInfos extends StatelessWidget {

  final Employee employee;

  ProfilInfos({@required this.employee});


  @override
  Widget build(BuildContext context) {
     String nameAgency    = employee.agency?.name ?? " ";
     String addressAgency = employee.agency?.address ?? " "; 
  return Container(
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xFFFF9F9F9),
      boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5),spreadRadius: 5,blurRadius: 7,offset: Offset(0, 3),),
        ],
      ),
    child: Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.mail,color: Colors.blueGrey,),
          title: Text(capitalize(employee.email),style: TextStyle(fontSize: 17.0,fontFamily: "Times"),),
        ),
        Divider(indent: 20, endIndent: 20,),
        ListTile(
          leading: Icon(Icons.business, color: Colors.blueGrey,),
          title: Text(capitalize(nameAgency),style: TextStyle(fontSize: 17.0,fontFamily: "Times"),),
          subtitle: Text('$addressAgency',style: TextStyle(fontSize: 14.0,fontFamily: "Times"),),
          onTap: (){
            Navigator.pushNamed(context, '/Agency', arguments: employee.agency?.id);
          },
        ),
      ],
    ),
  );
  }
}