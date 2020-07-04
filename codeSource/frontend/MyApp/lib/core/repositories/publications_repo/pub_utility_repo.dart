import 'dart:convert';
import 'dart:io';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/models/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PubUtilityRepo {
  // our API adress
  final String _pubsUrl = "${DotEnv().env['API_URL']}/publications";
  // SharedPreferences api
  SharedPreferences storage;

  String get pubUrl => this._pubsUrl;

  Future<Map<String, String>> header() async {
    storage = await SharedPreferences.getInstance();
    String token = storage.getString('token');
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    return header;
  }

  Future<Map<String, String>> headerMultiPart() async {
    storage = await SharedPreferences.getInstance();
    String token = storage.getString('token');
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'multipart/form-data'
    };
    return header;
  }

  Publication parsePublicationsLikes(String response) {
    try {
      Map<String, dynamic> publicationDecoded = jsonDecode(response);
      Publication myPublication =
          Publication.fromJsonWithLikesObjects(publicationDecoded);
      return myPublication;
    } catch (err) {
      return Publication();
    }
  }

  List<Publication> parsePublications(String response) {
    try {
      List<dynamic> list = jsonDecode(response);
      List<Publication> myList =
          list.map((e) => Publication.fromJson(e)).toList();
      return myList;
    } catch (err) {
      print(err.toString());
      return new List<Publication>();
    }
  }

  List<Comment> parseComments(String response) {
    try {
      List<dynamic> list = jsonDecode(response);
      List<Comment> myList =
          list.map((e) => Comment.fromJson(e)).toList();
      return myList;
    } catch (err) {
      print(err.toString());
      return new List<Comment>();
    }
  }
}
