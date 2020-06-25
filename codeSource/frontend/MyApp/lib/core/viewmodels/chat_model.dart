import 'dart:async';

import 'package:MyApp/core/enum/user_on_line_status.dart';
import 'package:MyApp/core/constantes/socket_consts.dart' as globals;
import 'package:MyApp/core/models/chatMessageModel.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/services/chat_service.dart';
import 'package:MyApp/core/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:strings/strings.dart';

import '../enum/viewstate.dart';
import 'base_model.dart';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../../locator.dart';

class ChatModel extends BaseModel {
  final ChatService _chatService = locator<ChatService>();
  final SocketService _socketService = locator<SocketService>();

  List<ChatMessageModel> _chatMessages;
  Employee _toChatUser;
  UserOnlineStatus _userOnlineStatus;
  TextEditingController _chatTextController;
  ScrollController _chatListController;
  Map<DateTime, Timer> _timers;
  bool _isUserStatusChecked;

  List<ChatMessageModel> get chatMessages => _chatMessages;
  Employee get toChatUser => _toChatUser;
  UserOnlineStatus get userOnlineStatus => _userOnlineStatus;
  TextEditingController get chatTextController => _chatTextController;
  ScrollController get chatListController => _chatListController;
  bool get isUserStatusChecked => _isUserStatusChecked;

  Future init(Employee fromChatUser, Employee toChatUser) async {
    setState(ViewState.Busy);

    _timers = new Map<DateTime, Timer>();
    this._isUserStatusChecked = false;
    this._chatTextController = TextEditingController();
    this._chatListController = ScrollController(initialScrollOffset: 0);
    this._toChatUser = toChatUser;
    this._userOnlineStatus = UserOnlineStatus.connecting;
    this._chatMessages = List<ChatMessageModel>();

    await loadMessages(getChatId(fromChatUser.id, _toChatUser.id));
    _socketService.initSocketListeners(this.onMessageStatusChanged, this.onMessageReceive, this.onUserOnlineStatus);
    this.checkOnline();

    setState(ViewState.Idle);
  }

  void checkOnline() {
    // wait one second after emitting the checkOnline event and then check if user status is checked, if not repeat the process
    // because it might send event and receive response from the server and the socket doesn't unregister its old listeners with callbacks associated to the previous modelView
    // and then we loose the response to this action event
    _chatService.checkOnline(_toChatUser.id);
    Timer(Duration(seconds: 1), () {
      if(isUserStatusChecked == false){
        checkOnline();
      }
    });
  }

  void onMessageStatusChanged(ChatMessageModel chatMessageModel){
    stopTimer(chatMessageModel.date, chatMessageModel.status);
  }

  void onUserOnlineStatus(ChatMessageModel chatMessageModel){
    setState(ViewState.Busy);
    this._isUserStatusChecked = true;
    this._userOnlineStatus = chatMessageModel.toUserOnlineStatus
        ? UserOnlineStatus.online
        : UserOnlineStatus.not_online;
    setState(ViewState.Idle);
  }

  void onMessageReceive(ChatMessageModel chatMessageModel){
    setState(ViewState.Busy);
    _chatMessages.add(chatMessageModel);
    chatListScrollToBottom();
    playMessageReceivedSound();
    _chatService.sendMessageSeen(chatMessageModel);
    setState(ViewState.Idle);
  }

  void playMessageReceivedSound(){
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.receivedMessage,
      looping: false,
      volume: 1.0,
      asAlarm: false,
    );
  }

  Future loadMessages(String chatId) async {
    setState(ViewState.Busy);
    this._chatMessages = await _chatService.getMessagesForRoom(chatId);
    for(ChatMessageModel msg in _chatMessages){
      if(msg.from == _toChatUser.id && msg.status != globals.STATUS_MASSAGE_SEEN) {
        _chatService.sendMessageSeen(msg);
      }
    }
    setState(ViewState.Idle);
    chatListScrollToBottom();
  }

  String getChatId(fromId, toId) {
    if (fromId.compareTo(toId) > 0) return "$fromId , $toId";
    return "$toId , $fromId";
  }

  void chatListScrollToBottom() {
    Timer(Duration(milliseconds: 100), () {
      if (_chatListController.hasClients) {
        _chatListController.animateTo(
            _chatListController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100),
            curve: Curves.decelerate);
      }
    });
  }

  void sendMessage(String fromId) async {
    setState(ViewState.Busy);
    String message = _chatTextController.text;
    String messageWithoutSpaces = message.split(' ').join('');
    print('Sending message to ${capitalize(_toChatUser.firstName+' '+_toChatUser.lastName)}, id: ${_toChatUser.id}');
    if (messageWithoutSpaces.isNotEmpty){
      var chatId = getChatId(fromId, _toChatUser.id);
      var chatMessageModel = _chatService.sendMessage(chatId, message, fromId, _toChatUser.id);
      _chatMessages.add(chatMessageModel);
      setState(ViewState.Idle);
      startTimer(chatMessageModel.date);
    }
    _chatTextController.text = '';
    chatListScrollToBottom();
  }

  void resendMessage(ChatMessageModel message){
    setState(ViewState.Busy);
    for (ChatMessageModel msg in _chatMessages) {
      if (msg.date == message.date)
        msg.status = globals.STATUS_MASSAGE_SENDING;
    }
    if(_timers.containsKey(message.date)){
      _timers.remove(message.date);
    }
    _chatService.resentMessage(message);
    setState(ViewState.Idle);
    startTimer(message.date);
  }

  void startTimer(DateTime dateOfRelatedMessage){
    _timers.putIfAbsent(dateOfRelatedMessage, () => new Timer(Duration(seconds: 10), () {
      setState(ViewState.Busy);
      for (ChatMessageModel msg in _chatMessages) {
        if (msg.date == dateOfRelatedMessage)
          msg.status = globals.STATUS_MASSAGE_NOT_SENT;
      }
      setState(ViewState.Idle);
    }));
  }

  void stopTimer(DateTime dateOfRelatedMessage, int status){
    setState(ViewState.Busy);
    if(_timers[dateOfRelatedMessage].isActive)
      _timers[dateOfRelatedMessage].cancel();
    _timers.remove(dateOfRelatedMessage);
    for (ChatMessageModel msg in _chatMessages) {
      if (msg.date == dateOfRelatedMessage)
        msg.status = status;
    }
    setState(ViewState.Idle);
  }

  void dispose(){
    _socketService.removeSocketListeners();
    super.dispose();
  }
}