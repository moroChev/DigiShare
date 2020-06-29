class ChatMessageModel {
  ChatMessageModel({
    this.id,
    this.chatId,
    this.to,
    this.from,
    this.message,
    this.chatType,
    this.toUserOnlineStatus,
    this.date,
    this.status,
  });

  String id;
  String chatId;
  String to;
  String from;
  String message;
  String chatType;
  bool toUserOnlineStatus;
  DateTime date;
  int status;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
    id: json["_id"] as String,
    chatId: json["chat_id"] as String,
    to: json["to"] as String,
    from: json["from"] as String,
    message: json["message"] as String,
    chatType: json["chat_type"] as String,
    toUserOnlineStatus: json["to_user_online_status"] as bool,
    date: DateTime.parse(json["sent_at"].toString()),
    status: json["status"] as int,
  );

  Map<String, dynamic> toJson() => {
    "chat_id": chatId,
    "to": to,
    "from": from,
    "message": message,
    "chat_type": chatType,
    "to_user_online_status": toUserOnlineStatus,
    "sent_at": date.toString(),
    "status": status,
  };
}
