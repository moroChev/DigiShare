import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/models/chatMessageModel.dart';
import 'package:MyApp/core/models/roomModel.dart';
import 'package:MyApp/core/services/messages_service.dart';
import 'package:MyApp/core/services/socket_service.dart';
import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:MyApp/locator.dart';

class MessagesModel extends BaseModel{
  final MessagesService _messagesService = locator<MessagesService>();
  final SocketService _socketService = locator<SocketService>();

  List<RoomModel> _rooms;

  List<RoomModel> get rooms => _rooms;

  Future init(String loggedInUserId) async {
    setState(ViewState.Busy);
    await getRoomsFor(loggedInUserId);
    _socketService.initSocketListeners(null, this.onMessageReceive, null);
    setState(ViewState.Idle);
  }

  Future getRoomsFor(String userId) async {
    List<RoomModel> fetchedRooms = await _messagesService.getAllRooms(userId);
    _rooms = fetchedRooms == null ? List<RoomModel>() : fetchedRooms;
  }

  void onMessageReceive(ChatMessageModel chatMessageModel) async {
    setState(ViewState.Busy);
    await updateRoom(chatMessageModel);
    playMessageReceivedSound();
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

  Future updateRoom(ChatMessageModel chatMessageModel) async {
    bool updated = false;
    for(RoomModel room in  _rooms){
      if(room.chatId == chatMessageModel.chatId){
        room.lastMessage = chatMessageModel;
        updated = true;
      }
    }
    if(updated == false){
      RoomModel newRoom = await _messagesService.getRoomByRoomId(chatMessageModel.chatId);
      _rooms.add(newRoom);
    }
    _rooms.sort((a,b){
      return b.lastMessage.date.difference(a.lastMessage.date).inMilliseconds;
    });
  }

  void dispose(){
    _socketService.removeSocketListeners();
    super.dispose();
  }
}