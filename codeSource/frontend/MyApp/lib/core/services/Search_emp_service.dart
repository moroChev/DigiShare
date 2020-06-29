import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/repositories/employee_repo.dart';
import 'package:MyApp/locator.dart';
import 'package:flutter/material.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_list_tile.dart';


class SearchEmployee extends SearchDelegate<Employee>{

 EmployeeRepo _employeeRepo = locator<EmployeeRepo>();

   @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: "Times"
            ),
          ),
          cardTheme: CardTheme(
             color: Colors.white,
             shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                side: BorderSide(color: Colors.black),
            )
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
          primaryColor: Colors.blue[100],
        );
  }

   @override
  List<Widget> buildActions(BuildContext context) {
    return [  
      AnimatedOpacity(
        opacity: query.isNotEmpty ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOutCubic,
        child: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => query = '',
             ),
         ),
      ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if(query.isEmpty)
    {
      return Container(height: 0,width: 0,);
    }else
    return FutureBuilder<List<Employee>>(
                    future: _employeeRepo.searchQuery(query),
                    builder: (context,snapshot){
                      if(snapshot.hasData ){
                          List<Employee> employeesFromSnapShot = snapshot.data;
                          return ListView.builder(
                            itemCount: employeesFromSnapShot.length,
                            itemBuilder: (context,index){
                            // return CircularProgressIndicator();
                              return EmployeeListTile(employee: employeesFromSnapShot[index], subtitle: employeesFromSnapShot[index].agency.name);
                              }
                            );
                      }else if(snapshot.hasError){
                          print("lerreur est : ${snapshot.error}");
                          return Center(child:Text("no result for $query !"));
                      }else{
                          return Center(child:CircularProgressIndicator());
                        }
                    }
                  );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty)
    {
      return Container(height: 0,width: 0,);
    }else
    return FutureBuilder<List<Employee>>(
                    future: _employeeRepo.getEmployeesForSuggestions(),
                    builder: (context,snapshot){
                      if(snapshot.hasData ){
                        print("suggestions ... hasData ");
                        //After receiving the whole list of employees for suggestion,
                        // here i am starting from the idea of the user is quereing with lower case  
                        List<Employee> employeesFromSnapShot = snapshot.data.where((element) => (element.firstName.toLowerCase().startsWith(query) || element.lastName.toLowerCase().startsWith(query) )).toList();
                          return ListView.builder(
                            itemCount: employeesFromSnapShot.length,
                            itemBuilder: (context,index){
                              return EmployeeListTile(employee: employeesFromSnapShot[index], subtitle: employeesFromSnapShot[index].agency.name);
                              }
                            );
                      }else if(snapshot.hasError){
                          print("lerreur est : ${snapshot.error}");
                          return Center(child:Text("press search"));
                      }else{
                          return Center(child:CircularProgressIndicator());
                        }
                    }
                  );
  }




}