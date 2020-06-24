import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/services/authentication_service.dart';
import 'package:MyApp/core/services/chat_users_service.dart';
import 'package:MyApp/core/services/socket_service.dart';

import '../../locator.dart';
import 'base_model.dart';

class ChatUsersModel extends BaseModel {
  final ChatUsersService _chatUsersService = locator<ChatUsersService>();
  final SocketService _socketService = locator<SocketService>();

  List<Employee> _chatUsers;

  List<Employee> get chatUsers => _chatUsers;
  String get connectMessage => _socketService.connectMessage;

  Future init(Employee loggedInUser) async {
    setState(ViewState.Busy);
    await getUsersFor(loggedInUser);
    setState(ViewState.Idle);
  }

  Future getUsersFor(Employee user) async {
    List<Employee> allUsers = await _chatUsersService.getAllEmployees();
    List<Employee> filteredUsers = allUsers
        .where((u) => (!(u.id == user.id)))
        .toList();
    _chatUsers = filteredUsers == null ? List<Employee>() : filteredUsers;
  }

  void logout(){
    _socketService.disconnectSocket();
  }
}
