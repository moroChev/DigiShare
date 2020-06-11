import 'package:MyApp/Widgets/CustumAppBar.dart';
import 'package:MyApp/Widgets/SideMenuWidget.dart';
import 'package:MyApp/Widgets/floatingButton.dart';
import 'package:MyApp/entities/Employee.dart';
import 'package:flutter/material.dart';
import '../../entities/Publication.dart';
import '../../WebService/PublicationsController.dart';
import '../../Widgets/EmployeeListTile.dart';

class LikesWidget extends StatefulWidget {

  final String publicationId;
  LikesWidget({@required this.publicationId});

  @override
  _LikesWidgetState createState() => _LikesWidgetState();
}

class _LikesWidgetState extends State<LikesWidget> {
   
  Future<Publication> _publication;

  @override
  void initState() {
    super.initState();
    _publication = PublicationsController.getPublicationLikes(widget.publicationId);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: CustomAppBar.getAppBar(context),
          drawer: SideMenuWidget(),
          floatingActionButton: FloatingButton(),
          body: FutureBuilder<Publication>(
               future: _publication,
               builder: (context, snapshot){
                 if(snapshot.hasError) {return Center(child: Text("no likes and there an error you should verify !!!"),);}
                 else 
                 if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
                 {
                   List<Employee> employees = snapshot.data.likesEmployees;
                   return Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[

                       Padding(
                         padding: EdgeInsets.only(left: 35,top: 25,bottom: 25),
                         child:Text("Likes ${employees.length}",style: TextStyle(fontSize: 40, fontFamily: "Times"),) ,
                         ),
                       Expanded(
                         child: ListView.builder(
                           itemCount: employees.length,
                           itemBuilder: (context,index){
                             return EmployeeListTile(employee : employees[index]);
                           }),
                       ),
                     ],
                   );
                 }else{
                   return Center(child: CircularProgressIndicator());
                 }
               }
               ),
    );
  }


  

}