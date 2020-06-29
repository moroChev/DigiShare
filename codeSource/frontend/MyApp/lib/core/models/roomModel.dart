import 'chatMessageModel.dart';
import 'employee.dart';

class RoomModel {
  RoomModel({
    this.chatId,
    this.toId,
    this.fromId,
    this.toUser,
    this.fromUser,
    this.messages,
    this.lastMessage,
  });

  String chatId;
  String toId;
  String fromId;
  Employee toUser;
  Employee fromUser;
  List<ChatMessageModel> messages;
  ChatMessageModel lastMessage;

  /*factory RoomModel.fromJsonWithIds(Map<String, dynamic> json) => RoomModel(
    chatId: json["chat_id"] as String,
    toId: json["to"]["_id"] as String,
    fromId: json["from"]["_id"] as String,
    messages: (json["messages"] as List)?.map((e) => ChatMessageModel.fromJson(e))?.toList(),
    lastMessage: json["last_message"] == null ? ChatMessageModel() : ChatMessageModel.fromJson(json["last_message"]),
  );*/

  factory RoomModel.fromJsonWithObjects(Map<String, dynamic> json) => RoomModel(
    chatId: json["chat_id"] as String,
    toUser: Employee.fromJsonWithoutPostsAndAgency(json["to"]),
    fromUser: Employee.fromJsonWithoutPostsAndAgency(json["from"]),
    messages: (json["messages"] as List)?.map((e) => ChatMessageModel.fromJson(e))?.toList(),
    lastMessage: json["last_message"] == null ? ChatMessageModel() : ChatMessageModel.fromJson(json["last_message"]),
  );
}
