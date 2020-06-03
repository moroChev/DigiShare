import 'package:MyApp/entities/Employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Widgets/CustumAppBar.dart';
import '../WebService/EmployeesController.dart';
import '../Widgets/ProfilInformationsWidget.dart';

class Profil extends StatefulWidget {
  String employeeID;

  Profil(this.employeeID);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  //our Custum Appbar
  CustumAppBar appBar = new CustumAppBar();
  FlutterSecureStorage storage = FlutterSecureStorage();
  String _idEmployee ;
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
        body:  FutureBuilder(
                    future: _employee,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                       return Container(width: 0.0, height: 0.0);
                        
                      }else if( snapshot.hasData )
                      return snapshot.hasData
                          ? ProfilInformations(
                              profil: snapshot.data,
                            )
                          : Center(child: CircularProgressIndicator());
                    }),
        );
      
  }
}
