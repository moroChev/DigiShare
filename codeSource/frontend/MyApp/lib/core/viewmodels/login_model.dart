import 'package:MyApp/core/services/socket_service.dart';

import '../enum/viewstate.dart';
import '../services/authentication_service.dart';
import 'base_model.dart';

import '../../locator.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final SocketService _socketService = locator<SocketService>();

  String errorMessage;

  Future<bool> login(String login, String password) async {
    setState(ViewState.Busy);

      var loggedInUser = await _authenticationService.login(login, password);
      var success = loggedInUser != null;
      if(success){
        await _socketService.connectToSocket(loggedInUser);
      }else{
        errorMessage = "Failed to authenticate: login and/or password are incorrect";
      }

    setState(ViewState.Idle);
    return success;
  }
}