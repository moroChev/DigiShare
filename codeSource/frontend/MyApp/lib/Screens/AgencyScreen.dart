import 'package:MyApp/WebService/AgenciesController.dart';
import 'package:MyApp/Widgets/AgencyHeaderWidget.dart';
import 'package:MyApp/Widgets/AgencyInfoWidget.dart';
import 'package:MyApp/Widgets/EmployeesSectionWidget.dart';
import 'package:MyApp/Widgets/MapContainerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgencyScreen extends StatefulWidget {
  final String agencyId;

  AgencyScreen({this.agencyId});

  @override
  _AgencyScreenState createState() => _AgencyScreenState();
}

class _AgencyScreenState extends State<AgencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //App background
        backgroundColor: Colors.blueGrey[50],

        //Load data and display the screen content
        body: FutureBuilder(
            future: AgenciesController.fetchAgencyData(widget.agencyId),
            builder: (context, agencySnapshot) {
              if (agencySnapshot.hasError) {print(agencySnapshot.error);}
              return !agencySnapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                      children: <Widget>[
                        //********************************************************************
                        //Header Section
                        AgencyHeaderWidget(agency: agencySnapshot.data),

                        //********************************************************************
                        //Body Section

                        //Agency Info Container
                        AgencyInfoWidget(agency: agencySnapshot.data),

                        //Map Label
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('Our Subsidiaries', style: TextStyle(fontSize: 18, color: Colors.grey[500])),
                          ),
                        ),

                        // Map Container
                        // loading subsidiaries data and constructing the map
                        FutureBuilder(
                            future: AgenciesController.fetchAgencySubsidiaries(widget.agencyId),
                            builder: (context, subsidiariesSnapshot) {
                              if (subsidiariesSnapshot.hasError) {print(subsidiariesSnapshot.error);}
                              return subsidiariesSnapshot.hasData
                                  ? MapContainerWidget(agency: agencySnapshot.data, subsidiaries: subsidiariesSnapshot.data)
                                  : Center(child: CircularProgressIndicator());
                            }),

                        //Employees Section Label
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 30.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('Our Employees', style: TextStyle(fontSize: 18, color: Colors.grey[500])),
                          ),
                        ),

                        // Employees Container
                        // loading and then displaying employees data
                        FutureBuilder(
                          future: AgenciesController.fetchAgencyEmployees(widget.agencyId),
                          builder: (context, employeesSnapshot) {
                            if(employeesSnapshot.hasError){print(employeesSnapshot.error);}
                            return employeesSnapshot.hasData
                                ? EmployeesSectionWidget(employees: employeesSnapshot.data)
                                :  Center(child: CircularProgressIndicator());
                          },
                        ),

                        //Copyright Section
                        Padding(
                          padding: EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
                          child: Center(child:Text("Copyright  © 2020")),
                        ),
                      ],
                    );
            }));
  }
}
