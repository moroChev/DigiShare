import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../entities/Publication.dart';
import 'package:http_parser/http_parser.dart';
import '../Publications/Widgets/PostSettingsEnum.dart';


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


/// post http method to save the publication
/// whether it's a create or update method and the type is specified in requestType
  static Future<bool> postPublication({@required Publication publication,
                                        File imageUrl,
                                       @required  RequestChoices requestType
                                       }) async {
     String token              = await storage.read(key: 'token');
     Map<String,String> header = {
       HttpHeaders.authorizationHeader: 'Bearer $token',
       HttpHeaders.contentTypeHeader : 'multipart/form-data'
       };
     var request; 
     var uri;  

    if(requestType == RequestChoices.CREATE){
      print(" its a new post so creation");
      uri     = Uri.parse(API_URL);
      request = http.MultipartRequest('POST', uri, );
    }else if(requestType == RequestChoices.MODIFY){
      print(" its an old post so modification ${publication.id}");
      uri = Uri.parse("$API_URL/${publication.id}");
      request = http.MultipartRequest('PUT', uri, );
    }
    request 
      ..fields['content'] =publication.content
      ..fields['postedBy']=publication.postedBy.id
      ..headers.addAll(header);
      if(imageUrl!=null){
          request.files.add(await http.MultipartFile.fromPath(
          'imageUrl', imageUrl.path,
           contentType: MediaType('image', 'jpg')
          ));  
      }else{
            print("image is null so no need to send it");
          }
    var response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201){ 
      print('Uploaded!');
      return true;}
    else {
      print("erreur in sending the publication ...");
      return false;
      }
  }




// to a giving a publication
 static Future<bool> addLikePublication(String publicationId) async {
   String token                 = await storage.read(key: 'token');
   String userId                = await storage.read(key: 'userId');
   String url                   = "$API_URL/$publicationId/likes";
   Map<String,String> header    = {
       HttpHeaders.authorizationHeader: 'Bearer $token',
       HttpHeaders.contentTypeHeader  : 'application/json'
    };
   Map body                     = {"idEmployee": userId};  
   print("addLike method the user who liked is : $userId");
   final response               = await http.post(url,body: jsonEncode(body),headers: header);
   print(response.statusCode);
   if(response.statusCode==201 || response.statusCode==200){
      print('Like added !');
      return true;
   }else{
      print("erreur in liking the publication ...");
      return false;
   }
 }

 static Future<bool> removeLikePublication(String publicationId) async {
   String token                 = await storage.read(key: 'token');
   String url                   = "$API_URL/$publicationId/likes";
   Map<String,String> header    = {
       HttpHeaders.authorizationHeader: 'Bearer $token',
       HttpHeaders.contentTypeHeader  : 'application/json'
    };
   final response               = await http.delete(url,headers: header);
   print(response.statusCode);
   if(response.statusCode==201 || response.statusCode==200){
      print('Like added !');
      return true;
   }else{
      print("erreur in liking the publication ...");
      return false;
   }

 }

static Future<Publication> getPublicationLikes(String publicationId) async{
   String token                 = await storage.read(key: 'token');
   String url                   = "$API_URL/$publicationId/likes";
   Map<String,String> header    = {
       HttpHeaders.authorizationHeader: 'Bearer $token',
       HttpHeaders.contentTypeHeader  : 'application/json'
    }; 
    print("publication id to get likes ....  $publicationId");
   final response               = await http.get(url, headers: header);
   print(response.statusCode);
 try{ 
  if(response.statusCode==201 || response.statusCode==200){
      print('Uploaded!');
      return compute(parsePublicationsLikes, response.body);
   }else{
      print("erreur in liking the publication ...");
      throw Exception('Failed to load publications Data');
   }
   }catch(err){
     return new Publication();
   }
 }



 static Future<bool> deletePublication(String publicationId) async {

   String token                 = await storage.read(key: 'token');
   String url                   = "$API_URL/$publicationId";
   Map<String,String> header    = {
       HttpHeaders.authorizationHeader: 'Bearer $token',
       HttpHeaders.contentTypeHeader  : 'application/json'
    };
   final response               = await http.delete(url,headers: header);
   print(response.statusCode);
   if(response.statusCode==201 || response.statusCode==200){
      print('Like added !');
      return true;
   }else{
      print("erreur in liking the publication ...");
      return false;
   }
   
 }

 static Future<bool> approvePublication(String publicationId,bool isApproved) async {
   print("approve Publication that been sended is ... to pub : $publicationId"); 
   String token                 = await storage.read(key: 'token');
   String url                   = "$API_URL/$publicationId/approve";
   Map<String,String> header    = {
       HttpHeaders.authorizationHeader: 'Bearer $token',
       HttpHeaders.contentTypeHeader  : 'application/json'
    };
   Map<String,dynamic> body = {
     "isApproved" : isApproved
   };
   final response               = await http.post(url, body: jsonEncode(body), headers: header);
   print(response.statusCode);
   if(response.statusCode==201 || response.statusCode==200){
      print('Like added !');
      return true;
   }else{
      print("erreur in liking the publication ...");
      return false;
   }
   
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

   Publication parsePublicationsLikes(String response){
   try {
    Map<String,dynamic> publicationDecoded       = jsonDecode(response);
    print('publication decoded ... $publicationDecoded');
    Publication myPublication =  Publication.fromJsonWithLikesObjects(publicationDecoded);
    print('After parsing Publications ....... $myPublication');
    print("presenting Publications is over .....");
    return myPublication;
  } catch (err) {
    print(err.toString());
    return Publication();
  }
}
