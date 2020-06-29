import 'dart:async';

import 'package:MyApp/core/models/employee.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:strings/strings.dart';

import '../constantes/socket_consts.dart' as globals;
import '../models/chatMessageModel.dart';

class SocketRepo {
  Employee _fromUser;
  SocketIO _socket;
  SocketIOManager _manager;
  bool isOnMsgRcv;
  bool isOnMsgStatusChanged;
  bool isOnUserOnlineStatus;

  initSocket(Employee fromUser) async {
    this._fromUser = fromUser;
    isOnMsgRcv = false;
    isOnMsgStatusChanged = false;
    isOnUserOnlineStatus = false;
    print(
        'Connecting...${capitalize(fromUser.firstName + ' ' + fromUser.lastName)}...');
    _manager = SocketIOManager();
    _socket = await _manager.createInstance(_socketOptions());
  }

  _socketOptions() {
    final Map<String, String> userMap = {
      'from': _fromUser.id.toString(),
    };
    return SocketOptions(
      globals.connectUrl,
      enableLogging: true,
      transports: [Transports.WEB_SOCKET],
      query: userMap,
    );
  }

  connectToSocket() {
    if (null == _socket) {
      print('Socket is null');
      return;
    }
    print("connect this socket to server ..");
    _socket.connect();
  }

  setOnConnectListener(Function onConnect) {
    _socket.onConnect((data) {
      onConnect(data);
    });
  }

  setOnConnectionTimeOutListener(Function onConnectionTimeOut) {
    _socket.onConnectTimeout((data) {
      onConnectionTimeOut(data);
    });
  }

  setOnConnectionErrorListener(Function onConnectionError) {
    _socket.onConnectError((data) {
      onConnectionError(data);
    });
  }

  setOnErrorListener(Function onError) {
    _socket.onError((data) {
      onError(data);
    });
  }

  setOnDisconnectListener(Function onDisconnect) {
    _socket.onDisconnect((data) {
      onDisconnect(data);
    });
  }

  closeConnection() {
    if (null != _socket) {
      print('Closing Connection');
      _manager.clearInstance(_socket);
    }
  }

  sendSingleChatMessage(ChatMessageModel chatMessageModel) async {
    // if socket is not initialized yet, then break
    if (null == _socket) {
      print('Cannot send message');
    }
    // if socket is not connected yet, wait one second and repeat
    // in order to not loose the msg while waiting for connection to be done
    // and to delay a few the second emit if the first is failed
    // (because if an emit failed it will be resent automatically by socket
    // and the delay between two successive emits is too short so in this case we might have repetition of a single msg)
    else if (await _socket.isConnected() == false) {
      Timer(Duration(seconds: 1), () {
        sendSingleChatMessage(chatMessageModel);
      });
    }
    // if socket is well connected, proceed and send the msg
    else if (await _socket.isConnected() == true)
      _socket
          .emit(globals.EVENT_SINGLE_CHAT_MESSAGE, [chatMessageModel.toJson()]);
  }

  setOnChatMessageReceiveListener(Function onMessageReceived, Function callback) {
    // to avoid re-registering the listener before unregistering the old one
    //if not yet unregistered, wait 100 milliseconds and repeat
    if (onMessageReceived != null && isOnMsgRcv == true) {
      Timer(Duration(milliseconds: 100), () {
        setOnChatMessageReceiveListener(onMessageReceived, callback);
      });
    }
    // else if already unregistered, proceed and register it with the new values
    else if (onMessageReceived != null && isOnMsgRcv == false) {
      isOnMsgRcv = true;
      _socket.on(globals.ON_MESSAGE_RECEIVED, (data) {
        onMessageReceived(data, callback);
      });
    }
    // and finally if we want to unregister it, we check first if it's registered
    else if (onMessageReceived == null && isOnMsgRcv == true) {
      isOnMsgRcv = false;
      _socket.off(globals.ON_MESSAGE_RECEIVED);
    }
  }

  setOnChatMessageStatusChangedListener(Function onMessageStatusChanged, Function callback) {
    // to avoid re-registering the listener before unregistering the old one
    //if not yet unregistered, wait 100 milliseconds and repeat
    if (onMessageStatusChanged != null && isOnMsgStatusChanged == true) {
      Timer(Duration(milliseconds: 100), () {
        setOnChatMessageStatusChangedListener(onMessageStatusChanged, callback);
      });
    }
    // else if already unregistered, proceed and register it with the new values
    else if (onMessageStatusChanged != null && isOnMsgStatusChanged == false) {
      isOnMsgStatusChanged = true;
      _socket.on(globals.ON_MESSAGE_STATUS_CHANGED, (data) {
        onMessageStatusChanged(data, callback);
      });
    }
    // and finally if we want to unregister it, we check first if it's registered
    else if (onMessageStatusChanged == null && isOnMsgStatusChanged == true) {
      isOnMsgStatusChanged = false;
      _socket.off(globals.ON_MESSAGE_STATUS_CHANGED);
    }
  }

  checkOnLine(ChatMessageModel chatMessageModel) async {
    // if socket is not initialized yet then break
    if (null == _socket) {
      print('Cannot Check Online');
    }
    // if socket is not connected yet or the listener on user online status is not set yet, wait 100 milliseconds and repeat
    // in order to not loose the action
    else if (await _socket.isConnected() == false || isOnUserOnlineStatus == false) {
      Timer(Duration(milliseconds: 100), () {
        checkOnLine(chatMessageModel);
      });
    }
    // if socket is well connected and the listener is set, proceed and send the action event
    else {
      print('Checking Online User: ${chatMessageModel.to}');
      _socket.emit(globals.IS_USER_ONLINE_EVENT, [chatMessageModel.toJson()]);
    }
  }

  setOnlineUserStatusListener(Function onUserStatus, Function callback) {
    // to avoid re-registering the listener before unregistering the old one
    //if not yet unregistered wait 100 milliseconds and repeat
    if (onUserStatus != null && isOnUserOnlineStatus == true) {
      Timer(Duration(milliseconds: 100), () {
        setOnlineUserStatusListener(onUserStatus, callback);
      });
    }
    // else if already unregistered, proceed and register it with the new values
    else if (onUserStatus != null && isOnUserOnlineStatus == false) {
      isOnUserOnlineStatus = true;
      _socket.on(globals.ON_USER_ONLINE, (data) {
        onUserStatus(data, callback);
      });
    }
    // and finally if we want to unregister it, we check first if it's registered
    else if (onUserStatus == null && isOnUserOnlineStatus == true) {
      isOnUserOnlineStatus = false;
      _socket.off(globals.ON_USER_ONLINE);
    }
  }

  sendMessageSeen(ChatMessageModel chatMessageModel) {
    print(
        'Sending Message seen event of the msg sent at ${chatMessageModel.date}');
    if (null == _socket) {
      print('Cannot send Message Seen');
      return;
    }
    _socket.emit(globals.EVENT_MESSAGE_SEEN, [chatMessageModel.toJson()]);
  }
}
