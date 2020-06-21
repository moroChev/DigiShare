import '../enum/viewstate.dart';
import '../services/authentication_service.dart';
import 'base_model.dart';

import '../../locator.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  String errorMessage;

  Future<bool> login(String login, String password) async {
    setState(ViewState.Busy);
    var success = await _authenticationService.login(login, password);
    if(!success){
      errorMessage = "Failed to authenticate: login and/or password are incorrect";
    }
    setState(ViewState.Idle);
    return success;
  }
}