import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signup_ui/Widgets/ProfilInformationsWidget.dart';
import '../Widgets/CustumAppBar.dart';
import '../WebService/EmployeesController.dart';

class Profil extends StatefulWidget {
  String employeeID;

  Profil({this.employeeID});

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  //our Custum Appbar
  CustumAppBar appBar = new CustumAppBar();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(' initial de profil ');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: CustumAppBar.getAppBar(context),
        body:  FutureBuilder(
                    future: EmployeesController.fetchProfilData(widget.employeeID),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      return snapshot.hasData
                          ? ProfilInformations(
                              profil: snapshot.data,
                            )
                          : Center(child: CircularProgressIndicator());
                    }),
        );
      
  }
}
