import 'package:MyApp/WebService/AgenciesController.dart';
import 'package:MyApp/Widgets/AgencyHeaderWidget.dart';
import 'package:MyApp/Widgets/AgencyInfoWidget.dart';
import 'package:MyApp/Widgets/DividerWithTitleWidget.dart';
import 'package:MyApp/Widgets/EmployeesSectionWidget.dart';
import 'package:MyApp/Widgets/MapContainerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/CustumAppBar.dart';

class AgencyScreen extends StatefulWidget {
  final String agencyId;

  AgencyScreen({@required this.agencyId});

  @override
  _AgencyScreenState createState() => _AgencyScreenState();
}

class _AgencyScreenState extends State<AgencyScreen> {
  @override
  Widget build(BuildContext context) {
    print("Agency screen ... ${widget.agencyId}");
    return Scaffold(
        appBar: CustomAppBar.getAppBar(context),
        //App background
        backgroundColor: Colors.blueGrey[50],

        //Load data and display the screen content
        body: FutureBuilder(
            future: AgenciesController.fetchAgencyData(widget.agencyId),
            builder: (context, agencySnapshot) {
              if (agencySnapshot.hasError) {print(agencySnapshot.error);return Container(height: 0,width: 0,);}
              else{
                print("i have snapshot ...");
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

                        /* //Map Label
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('Trouvez nous', style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                          ),
                        ), */

                        DividerWithTitle(title: "Trouvez Nous"),

                        // Map Container
                        // loading subsidiaries data and constructing the map
                        FutureBuilder(
                            future: AgenciesController.fetchAgencySubsidiaries(widget.agencyId),
                            builder: (context, subsidiariesSnapshot) {
                              if (subsidiariesSnapshot.hasError) {print("error in fetching subsdiaries ... "+ subsidiariesSnapshot.error);}
                              return subsidiariesSnapshot.hasData
                                  ? MapContainerWidget(agency: agencySnapshot.data, subsidiaries: subsidiariesSnapshot.data)
                                  : Center(child: CircularProgressIndicator());
                            }),

                        //Employees Section Label
                      /*   Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 30.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('Nos Collaborateurs', style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                          ),
                        ), */

                        DividerWithTitle(title: "Nos Collaborateurs"),

                        // Employees Containerr
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
            }
            }
            )
            );
  }
}
