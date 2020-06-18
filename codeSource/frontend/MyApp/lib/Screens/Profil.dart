import 'package:MyApp/Widgets/ProfilInformationsWidget.dart';
import 'package:MyApp/Widgets/floatingButton.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/CustumAppBar.dart';
import '../WebService/EmployeesController.dart';
import '../publications/SinglePublicationWidget.dart';
import '../Widgets/DividerWithTitleWidget.dart';

class Profil extends StatefulWidget {
  
  final String employeeID;
  Profil({@required this.employeeID});


  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  
  Future<Employee> _employee;
  

  @override
  void initState() {
    super.initState();
      _employee=EmployeesController.fetchProfilData(id: widget.employeeID);
  }

  @override
  Widget build(BuildContext context) {
    print("profil for id :${widget.employeeID}");
    return  Scaffold(
          appBar: CustomAppBar.getAppBar(context),
          floatingActionButton: FloatingButton(),
          body: FutureBuilder<Employee>(
                      future: _employee,
                      builder: (context, snapshot) {
                      if (snapshot.hasError) 
                         return Container(width: 0.0, height: 0.0);
                      else if( snapshot.hasData && snapshot.connectionState == ConnectionState.waiting )
                         return Center(child: CircularProgressIndicator());
                      else if( snapshot.hasData && snapshot.connectionState == ConnectionState.done ) 
                     {  Employee employeA = snapshot.data;
                         return snapshot.hasData!=null
                            ?
                            _theContainer(employeA)
                            : Center(child: CircularProgressIndicator());
                     }else{
                       return Center(child: CircularProgressIndicator());
                     }
                }
              ),
        
    );
      
  }



Widget _theContainer(Employee employee){
return  Container(

              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFF7F7F7), Colors.blue[50]])),
              child: Column(
                children: <Widget>[
                  Expanded(child:
                  ListView(children:<Widget>[ 
                  ProfilInformations( profil: employee,),   
                  DividerWithTitle(title: "Publications"), 
                  publicationsList(employee.publicationsObjects, employee),               
                  ]
                  ),
                  ),        
                ],
              )
              );
}




Widget publicationsList(List<Publication> posts, Employee emp) {
  return posts?.length ==0 ?
   Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[ 
     Text("M. ${emp.lastName} n'\ a aucune publication",style: TextStyle(color: Colors.blueGrey,fontFamily:"Times"),)])
   :
   Column(children: posts?.map((post) => SinglePublicationWidget(publication: post,poster: emp,))?.toList());

}


}