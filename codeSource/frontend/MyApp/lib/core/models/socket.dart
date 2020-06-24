import 'package:MyApp/core/models/employee.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:strings/strings.dart';

import '../constantes/socket_consts.dart' as globals;
import 'chatMessageModel.dart';

class Socket{
  Employee _fromUser;
  SocketIO _socket;
  SocketIOManager _manager;

  initSocket(Employee fromUser) async {
    this._fromUser = fromUser;
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
    _socket.connect();
  }

  setOnConnectListener(Function onConnect, Function callback) {
    _socket.onConnect((data) {
      onConnect(data, callback);
    });
  }

  setOnConnectionTimeOutListener(Function onConnectionTimeOut, Function callback) {
    _socket.onConnectTimeout((data) {
      onConnectionTimeOut(data, callback);
    });
  }

  setOnConnectionErrorListener(Function onConnectionError, Function callback) {
    _socket.onConnectError((data) {
      onConnectionError(data, callback);
    });
  }

  setOnErrorListener(Function onError, Function callback) {
    _socket.onError((data) {
      onError(data, callback);
    });
  }

  setOnDisconnectListener(Function onDisconnect, Function callback) {
    _socket.onDisconnect((data) {
      onDisconnect(data, callback);
    });
  }

  closeConnection() {
    if (null != _socket) {
      print('Closing Connection');
      _manager.clearInstance(_socket);
    }
  }

  sendSingleChatMessage(ChatMessageModel chatMessageModel) async {
    if (null == _socket) {
      print('Cannot send message');
      return;
    }
    if(await _socket.isConnected() == true)
      _socket.emit(globals.EVENT_SINGLE_CHAT_MESSAGE, [chatMessageModel.toJson()]);
  }

  setOnChatMessageReceiveListener(Function onMessageReceived, Function callback) {
    if(onMessageReceived != null) {
      _socket.on(globals.ON_MESSAGE_RECEIVED, (data) {
        onMessageReceived(data, callback);
      });
    }else{
      _socket.off(globals.ON_MESSAGE_RECEIVED);
    }
  }

  setOnChatMessageStatusChangedListener(Function onMessageStatusChanged, Function callback) {
    if(onMessageStatusChanged != null){
      _socket.on(globals.ON_MESSAGE_STATUS_CHANGED, (data) {
        onMessageStatusChanged(data, callback);
      });
    }else{
      _socket.off(globals.ON_MESSAGE_STATUS_CHANGED);
    }
  }

  checkOnLine(ChatMessageModel chatMessageModel) {
    print('Checking Online User: ${chatMessageModel.to}');
    if (null == _socket) {
      print('Cannot Check Online');
      return;
    }
    _socket.emit(globals.IS_USER_ONLINE_EVENT, [chatMessageModel.toJson()]);
  }

  setOnlineUserStatusListener(Function onUserStatus, Function callback) {
    if(onUserStatus != null){
      _socket.on(globals.ON_USER_ONLINE, (data) {
        onUserStatus(data, callback);
      });
    }else{
      _socket.off(globals.ON_USER_ONLINE);
    }
  }

  sendMessageSeen(ChatMessageModel chatMessageModel) {
    print('Sending Message seen event of the msg sent at ${chatMessageModel.date}');
    if (null == _socket) {
      print('Cannot send Message Seen');
      return;
    }
    _socket.emit(globals.EVENT_MESSAGE_SEEN, [chatMessageModel.toJson()]);
  }
}
