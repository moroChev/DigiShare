
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:signup_ui/entities/Publication.dart';




List<Publication> parsePublications(String response ){
 try{ 
        List<dynamic> list = jsonDecode(response);
    List<Publication> myList = list.map((e) => Publication.fromJson(e)).toList();

    print('parsing Publications ....... ');
    return myList;
    }catch(err){
      print(err.toString());
    }
  }
class PublicationsController{

  // our API adress
  static final String API_URL = "http://localhost:3000/api/publications";
  // secure storage api
 static FlutterSecureStorage storage = FlutterSecureStorage();



  static Future<List<Publication>> fetchPublications() async{
   try{  
          String token = await storage.read(key: 'token');
          final response = await http.get(API_URL, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
          if(response.statusCode == 200){
            print('tryning to isolate ---------------------------------------- ${response.body}');     
            return compute(parsePublications, response.body );
          }else{
            throw Exception('Failed to load publications Data');
          }
    }catch(error){
      print(error.toString());
    }
  }

}