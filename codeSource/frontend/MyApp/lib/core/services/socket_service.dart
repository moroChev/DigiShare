import 'package:MyApp/core/models/chatMessageModel.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:strings/strings.dart';

import '../../locator.dart';
import '../repositories/socket_repo.dart';

class SocketService{
  String _connectMessage = "Connecting ...";
  SocketRepo _socket = locator<SocketRepo>();

  String get connectMessage => _connectMessage;

  Future connectToSocket(Employee loggedInUser) async {
    print('Connecting Logged In User ${capitalize(loggedInUser.firstName+' '+loggedInUser.lastName)}, ${loggedInUser.id}');
    await _socket.initSocket(loggedInUser);
    _socket.connectToSocket();
    _socket.setOnConnectListener(onConnect);
    _socket.setOnConnectionTimeOutListener(onConnectionTimeOut);
    _socket.setOnConnectionErrorListener(onConnectionError);
    _socket.setOnErrorListener(onError);
    _socket.setOnDisconnectListener(onDisconnect);
  }

  void onConnect(data) {
    print('Connected $data');
    _connectMessage = 'Connected';
  }

  void onConnectionTimeOut(data) {
    print('onConnectionTimeOut $data');
    _connectMessage = 'Connection Timed Out';
  }

  void onConnectionError(data) {
    print('onConnectionError $data');
    _connectMessage = 'Connection Error';
  }

  void onError(data) {
    print('onError $data');
    _connectMessage = 'Connection Error';
  }

  void onDisconnect(data) {
    print('onDisconnect $data');
    _connectMessage = 'Disconnected';
  }

  void disconnectSocket() {
    this.removeSocketListeners();
    _socket.closeConnection();
  }

  void initSocketListeners(Function msgStatusChangedCallback, Function msgReceiveCallback, Function onlineUserStatusCallback) {
    _socket.setOnChatMessageStatusChangedListener(onMessageStatusChanged, msgStatusChangedCallback);
    _socket.setOnChatMessageReceiveListener(onMessageReceived, msgReceiveCallback);
    _socket.setOnlineUserStatusListener(onUserStatus, onlineUserStatusCallback);
  }

  void removeSocketListeners() {
    _socket.setOnChatMessageStatusChangedListener(null, null);
    _socket.setOnChatMessageReceiveListener(null, null);
    _socket.setOnlineUserStatusListener(null, null);
  }

  void onUserStatus(data, callback) {
    print('onUserStatus $data');
    ChatMessageModel chatMessageModel = ChatMessageModel.fromJson(data);
    callback(chatMessageModel);
  }

  void onMessageStatusChanged(data, callback) {
    print('onMessageStatusChanged $data');
    ChatMessageModel chatMessageModel = ChatMessageModel.fromJson(data);
    callback(chatMessageModel);
  }

  void onMessageReceived(data, callback) {
    print('onMessageReceived $data');
    ChatMessageModel chatMessageModel = ChatMessageModel.fromJson(data);
    callback(chatMessageModel);
  }
}