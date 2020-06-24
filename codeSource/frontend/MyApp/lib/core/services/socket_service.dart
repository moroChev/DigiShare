import 'package:MyApp/core/models/chatMessageModel.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:strings/strings.dart';

import '../../locator.dart';
import '../models/socket.dart';

class SocketService{
  String _connectMessage = "Connecting ...";
  Socket _socket = locator<Socket>();

  String get connectMessage => _connectMessage;

  Future connectToSocket(Employee loggedInUser, Function callback) async {
    print('Connecting Logged In User ${capitalize(loggedInUser.firstName+' '+loggedInUser.lastName)}, ${loggedInUser.id}');
    await _socket.initSocket(loggedInUser);
    _socket.connectToSocket();
    _socket.setOnConnectListener(onConnect, callback);
    _socket.setOnConnectionTimeOutListener(onConnectionTimeOut, callback);
    _socket.setOnConnectionErrorListener(onConnectionError, callback);
    _socket.setOnErrorListener(onError, callback);
    _socket.setOnDisconnectListener(onDisconnect, callback);
  }

  void onConnect(data, callback) {
    print('Connected $data');
    _connectMessage = 'Connected';
    callback();
  }

  void onConnectionTimeOut(data, callback) {
    print('onConnectionTimeOut $data');
    _connectMessage = 'Connection Timed Out';
    callback();
  }

  void onConnectionError(data, callback) {
    print('onConnectionError $data');
    _connectMessage = 'Connection Error';
    callback();
  }

  void onError(data, callback) {
    print('onError $data');
    _connectMessage = 'Connection Error';
    callback();
  }

  void onDisconnect(data, callback) {
    print('onDisconnect $data');
    _connectMessage = 'Disconnected';
    callback();
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