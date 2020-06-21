import 'dart:convert';
import 'dart:io';
import 'package:MyApp/core/models/publication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:MyApp/core/enum/PostSettingsEnum.dart';
import 'package:http_parser/http_parser.dart';



class PublicationRepo{

// our API adress
  final String _pubsUrl         = "${DotEnv().env['API_URL']}/publications";
  // secure storage api
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<Map<String,String>> header() async {
    String token = await storage.read(key: 'token');
     Map<String,String> header    = {
       HttpHeaders.authorizationHeader: 'Bearer $token',
       HttpHeaders.contentTypeHeader  : 'application/json'
    };
    return header;
  }

  Future<Map<String,String>> headerMultiPart()async{
    String token = await storage.read(key: 'token');
    Map<String, String> header = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'multipart/form-data'
    };
  }


  Future<List<Publication>> fetchPublications() async {
    Map header     = await this.header();
    final response = await http.get(_pubsUrl, headers: header);
    if (response.statusCode == 200) {
      print(
          'tryning to isolate ---------------------------------------- ${response.body}');
      return compute(parsePublications, response.body);
    } else {
      throw Exception('Failed to load publications Data');
    }
  }

  Future<bool> addLikePublication(String publicationId, Map body) async {
   String url      = "$_pubsUrl/$publicationId/likes";
   Map header      = await this.header(); 
   final response  = await http.post(url,body: jsonEncode(body),headers: header);
   print(response.statusCode);
   if(response.statusCode==201 || response.statusCode==200){
      print('Like added !');
      return true;
   }else{
      print("erreur in liking the publication ...");
      return false;
   }
 }


   Future<bool> removeLikePublication(String publicationId) async {
    String url     = "$_pubsUrl/$publicationId/likes";
    Map header     = await this.header();
    final response = await http.delete(url, headers: header);
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Like removed !');
      return true;
    } else {
      print("erreur in liking the publication ...");
      return false;
    }
  }

  Future<Publication> getPublicationLikes(String publicationId) async {
    String url     = "$_pubsUrl/$publicationId/likes";
    Map header     = await this.header();
    final response = await http.get(url, headers: header);
    print(response.statusCode);
    try {
      if (response.statusCode == 201 || response.statusCode == 200) {
        return compute(parsePublicationsLikes, response.body);
      } else {
        throw Exception('Failed to load publications Data');
      }
    } catch (err) {
      return new Publication();
    }
  }













Future<bool> postPublication({
     @required Publication publication,
      File imageUrl,
      @required RequestChoices requestType}) async {
    Map header = await this.headerMultiPart();
    var request;
    var uri;
    if (requestType == RequestChoices.CREATE) {
      uri = Uri.parse(_pubsUrl);
      request = http.MultipartRequest('POST',uri,);
    } else if (requestType == RequestChoices.MODIFY) {
      uri = Uri.parse("$_pubsUrl/${publication.id}");
      request = http.MultipartRequest('PUT',uri,);
    }
    request
      ..fields['content'] = publication.content
      ..fields['postedBy'] = publication.postedBy.id
      ..headers.addAll(header);
    if (imageUrl != null) {
      request.files.add(await http.MultipartFile.fromPath('imageUrl', imageUrl.path, contentType: MediaType('image', 'jpg')));
    } 
    var response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Uploaded!');
      return true;
    } else {
      print("erreur in sending the publication ...");
      return false;
    }
  }

























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
    List<dynamic> list       = jsonDecode(response);
    List<Publication> myList = list.map((e) => Publication.fromJson(e)).toList();

    print('After parsing Publications ....... ');
    myList.forEach((element) => print(element));
    print("presenting Publications is over .....");
    return myList;
  } catch (err) {
    print(err.toString());
    return new List<Publication>();
  }
}