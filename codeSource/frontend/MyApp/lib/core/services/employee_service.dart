import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/repositories/employee_repo.dart';
import 'package:MyApp/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class EmployeeService{

  EmployeeRepo _empApi = locator<EmployeeRepo>();
  
  FlutterSecureStorage storage = FlutterSecureStorage();


  Future<Employee> fetchProfilData({ @required String idEmployee}) async {
    Employee employee = await this._empApi.fetchProfilData(idEmployee: idEmployee);
    return employee;
  }





}