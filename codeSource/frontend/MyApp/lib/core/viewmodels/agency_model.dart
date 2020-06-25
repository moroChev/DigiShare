import 'package:MyApp/core/models/agency.dart';
import 'package:MyApp/core/models/employee.dart';

import '../enum/viewstate.dart';
import '../services/agency_service.dart';
import 'base_model.dart';

import '../../locator.dart';

class AgencyModel extends BaseModel {
  
  final AgencyService _agencyService = locator<AgencyService>();

  Agency _agency;
  List<Employee> _employees;
  List<Agency> _subsidiaries;

  Agency get agency => _agency;
  List<Employee> get employees => _employees;
  List<Agency> get subsidiaries => _subsidiaries;

  Future getAgencyInfo(String agencyId) async {
    setState(ViewState.Busy);
    this._agency = await _agencyService.getAgencyInfo(agencyId);
    setState(ViewState.Idle);
  }

  Future getAgencyEmployees(String agencyId) async {
    setState(ViewState.Busy);
    this._employees = await _agencyService.getAgencyEmployees(agencyId);
    setState(ViewState.Idle);
  }

  Future getAgencySubsidiaries(String agencyId) async {
    setState(ViewState.Busy);
    this._subsidiaries = await _agencyService.getAgencySubsidiaries(agencyId);
    setState(ViewState.Idle);
  }

}