import 'package:MyApp/Widgets/floatingButton.dart';
import 'package:MyApp/entities/Employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/CustumAppBar.dart';
import '../WebService/EmployeesController.dart';
import '../Widgets/ProfilInformationsWidget.dart';

class Profil extends StatefulWidget {
  String employeeID;
  Profil({@required this.employeeID});


  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  //our Custum Appbar
  CustumAppBar appBar = new CustumAppBar();
  Future<Employee> _employee;
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _employee=EmployeesController.fetchProfilData(id: widget.employeeID);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: CustumAppBar.getAppBar(context),
        floatingActionButton: FloatingButton(),
        body:  FutureBuilder<Employee>(
                    future: _employee,
                    builder: (context, snapshot) {
                    if (snapshot.hasError) 
                       return Container(width: 0.0, height: 0.0);
                    else if( snapshot.hasData && snapshot.connectionState == ConnectionState.waiting )
                       return Center(child: CircularProgressIndicator());
                    else if( snapshot.hasData && snapshot.connectionState == ConnectionState.done ) 
                       return snapshot.hasData!=null
                          ? ProfilInformations(
                              profil: snapshot.data,
                            )
                          : Center(child: CircularProgressIndicator());
                    }),
        );
      
  }
}
