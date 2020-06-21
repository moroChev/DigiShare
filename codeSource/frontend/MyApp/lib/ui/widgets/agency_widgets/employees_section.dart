import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/viewmodels/agency_model.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../shared/emp_list_tile/employee_list_tile.dart';

class EmployeesSection extends StatelessWidget {

  
  final String agencyId;
  EmployeesSection({@required this.agencyId});

  @override
  Widget build(BuildContext context) {
    return BaseView<AgencyModel>(
      onModelReady: (model) => model.getAgencyEmployees(agencyId),
      builder: (context, model, child) => Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5.0),
        child: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : (model.employees.length == 0)
                ? Text('No employees yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[500]))
                : AspectRatio(
                    // 59 here refers to the approximate height of a single ListTile (employee)
                    // So (agency['employees'].length * 59 is the approximate height of our Wrap widget ...
                    // I think I made it clear enough here
                    aspectRatio: (MediaQuery.of(context).size.width / (model.employees.length * 76) < 3 / 4) ? 3 / 4
                        : MediaQuery.of(context).size.width / (model.employees.length * 76),
                    child: Material(
                      elevation: 15.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 5,
                          children: _buildEmployees(model.employees),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  //method to return a list of employee tiles
  List<Widget> _buildEmployees(List<Employee> employees) {
    // Widgets to return
    List<Widget> list = List<Widget>();
    for (Employee emp in employees) {
      //Single employee section
      Widget employee = Column(children: [
        EmployeeListTile(employee: emp),
        Divider(height: 1, color: Colors.blueGrey[200]),
      ]);
      list.add(employee);
    }
    return list;
  }
}
