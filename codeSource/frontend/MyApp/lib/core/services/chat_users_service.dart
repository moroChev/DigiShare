import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/repositories/employee_repo.dart';

import '../../locator.dart';

class ChatUsersService{
  final EmployeeRepo _api = locator<EmployeeRepo>();

  Future<List<Employee>> getAllEmployees() async {
    var fetchedEmployees = await _api.getEmployeesForSuggestions();
    var hasData = fetchedEmployees != null;
    if(hasData){
      print('${this.runtimeType.toString()}:---> contacts List fetched successfully');
    }
    else
      print('${this.runtimeType.toString()}:---> Failed to load contacts List');
    return fetchedEmployees;
  }
}
