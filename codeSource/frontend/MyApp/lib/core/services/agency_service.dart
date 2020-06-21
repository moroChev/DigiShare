import 'dart:async';

import 'package:MyApp/core/models/agency.dart';
import 'package:MyApp/core/repositories/agency_repo.dart';

import '../repositories/authentication_repo.dart';
import '../models/employee.dart';
import '../../locator.dart';

class AgencyService {
  
  AgencyRepo _api = locator<AgencyRepo>();

  Future<Agency> getAgencyInfo(String agencyId) async {
    var fetchedAgency = await _api.fetchAgencyInfoOnly(agencyId);
    var hasData = fetchedAgency != null;
    if(hasData)
      print('${this.runtimeType.toString()}:---> agency data fetched successfully');
    else
      print('${this.runtimeType.toString()}:---> Failed to load Agency Data');
    return fetchedAgency;
  }

  Future<List<Employee>> getAgencyEmployees(String agencyId) async {
    var fetchedAgency = await _api.fetchAllAgencyData(agencyId);
    var hasData = fetchedAgency != null;
    var employees;
    if(hasData){
      employees = fetchedAgency.employeesObjects;
      print('${this.runtimeType.toString()}:---> agency Employees List fetched successfully');
    }
    else
      print('${this.runtimeType.toString()}:---> Failed to load Agency Employees');
    return employees;
  }

  Future<List<Agency>> getAgencySubsidiaries(String agencyId) async {
    var fetchedAgency = await _api.fetchAllAgencyData(agencyId);
    var hasData = fetchedAgency != null;
    var subsidiaries;
    if(hasData){
      subsidiaries = fetchedAgency.subsidiariesObjects;
      print('${this.runtimeType.toString()}:---> agency Subsidiaries List fetched successfully');
    }
    else
      print('${this.runtimeType.toString()}:---> Failed to load Agency Subsidiaries');
    return subsidiaries;
  }
}