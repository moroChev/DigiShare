import 'dart:async';

import '../repositories/authentication_repo.dart';
import '../models/employee.dart';
import '../../locator.dart';

class AuthenticationService {
  AuthenticationRepo _api = locator<AuthenticationRepo>();
  StreamController<Employee> userController = StreamController<Employee>();

  Future<Employee> login(String login, String password) async {
    var fetchedUser = await _api.attemptLogIn(login, password);
    var hasUser = fetchedUser != null;
    if(hasUser) {
      print('${this.runtimeType.toString()}:---> saving user info');
      userController.add(fetchedUser);
    }
    return fetchedUser;
  }
}