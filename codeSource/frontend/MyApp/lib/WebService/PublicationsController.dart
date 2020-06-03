
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../entities/Publication.dart';
import 'package:http_parser/http_parser.dart';

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
  }
}

class PublicationsController {
  // our API adress
  static final String API_URL         = "http://localhost:3000/api/publications";
  // secure storage api
  static FlutterSecureStorage storage = FlutterSecureStorage();




  static Future<List<Publication>> fetchPublications() async {
    String token   = await storage.read(key: 'token');
    final response = await http.get(API_URL,
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    if (response.statusCode == 200) {
      print(
          'tryning to isolate ---------------------------------------- ${response.body}');
      return compute(parsePublications, response.body);
    } else {
      throw Exception('Failed to load publications Data');
    }
  }


// post http method to save the publication
  static Future<bool> postPublication(Publication publication, File imageUrl)async {
     String token              = await storage.read(key: 'token');
     Map<String,String> header = {
       HttpHeaders.authorizationHeader: 'Bearer $token',
       HttpHeaders.contentTypeHeader : 'multipart/form-data'
       };
    var uri = Uri.parse(API_URL);
    var request = http.MultipartRequest('POST', uri, )
      ..fields['content'] =publication.content
      ..fields['postedBy']=publication.postedBy.id
      ..headers.addAll(header);
      if(imageUrl!=null)
     {   
          request.files.add(await http.MultipartFile.fromPath(
          'imageUrl', imageUrl.path,
           contentType: MediaType('image', 'jpg')
          ));
          }else{
            print("image is null so no need to send it");
          }
    var response = await request.send();
    if (response.statusCode == 200){ 
      print('Uploaded!');
      return true;}
    else {
      print("erreur in sending the publication ...");
      return false;
      }
  }

// to a giving a publication
 static Future<bool> likePublication(String publicationId) async{
   String token                 = await storage.read(key: 'token');
   String userId                = await storage.read(key: 'userId');
   String url                   = "$API_URL/$publicationId/likes";
   Map<String,String> header    = {
       HttpHeaders.authorizationHeader: 'Bearer $token',
       HttpHeaders.contentTypeHeader  : 'application/json'
    };
   Map body                     = {"idEmployee": userId};  
   final response               = await http.post(url,body: jsonEncode(body),headers: header);
   print(response.statusCode);
   if(response.statusCode==201 || response.statusCode==200){
      print('Uploaded!');
      return true;
   }else{
      print("erreur in liking the publication ...");
      return false;
   }
 }
// to dislike a given publication
   static Future<bool> dislikePublication(String publicationId) async{
   String token                 = await storage.read(key: 'token');
   String userId                = await storage.read(key: 'userId');
   String url                   = "$API_URL/$publicationId/dislikes";
   Map<String,String> header    = {
       HttpHeaders.authorizationHeader: 'Bearer $token',
       HttpHeaders.contentTypeHeader  : 'application/json'
    };
   Map body                     = {"idEmployee": userId};  
   final response               = await http.post(url, body: jsonEncode(body), headers: header);
   print(response.statusCode);
   if(response.statusCode==201 || response.statusCode==200){
      print('Uploaded!');
      return true;
   }else{
      print("erreur in liking the publication ...");
      return false;
   }
 }

/*  Future<List<Employees>> getPublicationLikes(String id) async{



 } */





}
