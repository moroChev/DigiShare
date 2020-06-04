import 'package:MyApp/WebService/NetworkImageController.dart';
import 'package:MyApp/entities/Employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Screens/Profil.dart';

class EmployeesSectionWidget extends StatefulWidget {
  final List<Employee> employees;

  EmployeesSectionWidget({@required this.employees});

  @override
  _EmployeesSectionWidgetState createState() => _EmployeesSectionWidgetState();
}

class _EmployeesSectionWidgetState extends State<EmployeesSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10.0),
      child: (widget.employees.length == 0)? Text('No employees yet', style: TextStyle(fontSize: 18, color: Colors.grey[500])) : AspectRatio(
        // 59 here refers to the approximate height of a single ListTile (employee)
        // So (agency['employees'].length * 59 is the approximate height of our Wrap widget ...
        // I think I made it clear enough here
        aspectRatio: (MediaQuery.of(context).size.width/(widget.employees.length * 59) < 3/4)? 3/4 : MediaQuery.of(context).size.width/(widget.employees.length * 59),
        child: Material(
          elevation: 15.0,
          color: Color(0xff535880),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 5,
              children: _buildEmployees(),
            ),
          ),
        ),
      ),
    );
  }

  //method to return a list of employee tiles
  List<Widget> _buildEmployees(){
    // Widgets to return
    List<Widget> list = List<Widget>();
    for(Employee emp in widget.employees){
      //Single employee section
      Widget employee = Column(children: [
        buildCustomEmployee(emp),
        Divider(height: 1, color: Colors.blueGrey[200]),
      ]);
      list.add(employee);
    }
    return list;
  }

  //method to build a single employee tile
  static Widget buildCustomEmployee(Employee emp){
    //fetch profile avatar image and construct the tile
    return FutureBuilder(
      future: NetworkImageController.fetchImage(emp.imageUrl),
      builder: (BuildContext context, AsyncSnapshot<NetworkImage> image) {
        if(image.hasData){
          return ListTile(
              leading: (emp.imageUrl == null)
                  ? AssetImage('img/malePerson.jpg')
                  : CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.transparent,
                backgroundImage: image.data,
              ),
              title: Text(emp.firstName.toString() + " " + emp.lastName.toString()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Profil(employeeID: emp.id)));
              },
          );
        }
        else
          return Center(child: CircularProgressIndicator());
        },
    );
  }

}
