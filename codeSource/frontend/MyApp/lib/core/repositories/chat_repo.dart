import 'dart:convert';
import 'dart:io';

import 'package:MyApp/core/models/roomModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatRepo{
  static const endpoint = 'http://192.168.43.107:3000/api/messages';
  SharedPreferences storage;

  Future<Map<String,String>> header() async {
    storage = await SharedPreferences.getInstance();
    String token =  storage.getString('token');
    Map<String,String> header    = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader  : 'application/json'
    };
    return header;
  }

  // Method to fetch a Room by its chat_id
  Future<RoomModel> fetchRoom(String roomId) async {
    print("sending request to fetch messages from room ********************************");
    String url = "$endpoint/room/$roomId";
    Map header = await this.header();
    var response = await http.get(url, headers: header);
    var room;
    if(response.statusCode == 200)
      room = RoomModel.fromJsonWithObjects(json.decode(response.body));
    return room;
  }

  // Method to fetch all Rooms for a user
  Future<List<RoomModel>> fetchAllRoomsForUser(String id) async {
    print("sending request to fetch rooms for user ********************************");
    String url = "$endpoint/$id";
    Map header = await this.header();
    var response = await http.get(url, headers: header);
    var rooms;
    if(response.statusCode == 200){
      print(response.body);
      rooms = (json.decode(response.body) as List)?.map((room) => RoomModel.fromJsonWithObjects(room))?.toList();
    }
    return rooms;
  }
}