import 'package:MyApp/core/models/chatMessageModel.dart';
import 'package:MyApp/core/repositories/chat_repo.dart';
import '../repositories/socket_repo.dart';
import '../constantes/socket_consts.dart' as globals;

import '../../locator.dart';

class ChatService {
  ChatRepo _api = locator<ChatRepo>();
  SocketRepo _socket = locator<SocketRepo>();

  Future<List<ChatMessageModel>> getMessagesForRoom(String roomId) async {
    var fetchedRoom = await _api.fetchRoom(roomId);
    var hasData = fetchedRoom != null;
    var messages;
    if (hasData) {
      messages = fetchedRoom.messages;
      print('${this.runtimeType.toString()}:---> Room fetched successfully');
    } else {
      messages = List<ChatMessageModel>();
      print(
          "${this.runtimeType.toString()}:---> Failed to load Room Or Room doesn't exist");
    }
    return messages;
  }

  void sendMessageSeen(ChatMessageModel chatMessageModel) {
    chatMessageModel.status = globals.STATUS_MASSAGE_SEEN;
    _socket.sendMessageSeen(chatMessageModel);
  }

  void checkOnline(String toUserId) {
    ChatMessageModel chatMessageModel = ChatMessageModel(
      chatId: "it doesn't matter",
      from: "it doesn't matter",
      message: "it doesn't matter",
      chatType: globals.SINGLE_CHAT,
      date: DateTime.now(),
      status: globals.STATUS_MASSAGE_SENT,
      to: toUserId,
      toUserOnlineStatus: false,
    );
    _socket.checkOnLine(chatMessageModel);
  }

  ChatMessageModel sendMessage(
      String chatId, String message, String from, String to) {
    ChatMessageModel chatMessageModel = ChatMessageModel(
      chatId: chatId,
      to: to,
      from: from,
      toUserOnlineStatus: false,
      message: message,
      chatType: globals.SINGLE_CHAT,
      date: DateTime.now(),
      status: globals.STATUS_MASSAGE_SENDING,
    );
    _socket.sendSingleChatMessage(chatMessageModel);
    return chatMessageModel;
  }

  void resentMessage(ChatMessageModel chatMessageModel) {
    chatMessageModel.status = globals.STATUS_MASSAGE_SENDING;
    _socket.sendSingleChatMessage(chatMessageModel);
  }
}
