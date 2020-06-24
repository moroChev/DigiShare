import 'package:MyApp/core/models/roomModel.dart';
import 'package:MyApp/core/repositories/chat_repo.dart';
import 'package:MyApp/locator.dart';

class MessagesService{
  ChatRepo _api = locator<ChatRepo>();

  Future<List<RoomModel>> getAllRooms(String userId) async {
    var fetchedRooms = await _api.fetchAllRoomsForUser(userId);
    var hasData = fetchedRooms != null;
    if(hasData) {
      print('${this.runtimeType.toString()}:---> Rooms fetched successfully');
    }
    else {
      print("${this.runtimeType.toString()}:---> Failed to load Rooms Or Rooms doesn't exist yet");
    }
    return fetchedRooms;
  }

  Future<RoomModel> getRoomByRoomId(String roomId) async {
    var fetchedRoom = await _api.fetchRoom(roomId);
    var hasData = fetchedRoom != null;
    if (hasData) {
      print('${this.runtimeType.toString()}:---> Room fetched successfully');
    } else {
      print("${this.runtimeType.toString()}:---> Failed to load Room Or Room doesn't exist");
    }
    return fetchedRoom;
  }
}