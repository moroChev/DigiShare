import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/services/employee_service.dart';
import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:MyApp/locator.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/repositories/notifications_repo/notifications_repo.dart';




class ProfilModel extends BaseModel{

  EmployeeService _employeeService = locator<EmployeeService>();

  Employee _employee;

  Employee get employee => this._employee;

  fetchProfilData(String idEmployee) async {
    setState(ViewState.Busy);
    NotificationRepo.createSocket();
    this._employee = await this._employeeService.fetchProfilData(idEmployee: idEmployee);
    print("the employee profil .. ${this._employee}");
    setState(ViewState.Idle);
  }




}