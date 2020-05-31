import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController{
   
   static String API_URL_AUTH = "http://localhost:3000/api/auth";
   static FlutterSecureStorage storage = FlutterSecureStorage();


  
  static Future<bool> attemptLogIn(String login, String password) async {
    String url = "$API_URL_AUTH/login";
    print('attempt to login !! $login and $password to $url');
    Map body = {
      'login': login,
      'password': password
    };
    try{
          var res = await http.post(url, body: jsonEncode(body),headers: { 'Content-type': 'application/json'});
          print(res.statusCode);
          if(res.statusCode == 200)
          {
            print('request ok yes : '+res.body);
            Map jwt = jsonDecode(res.body);
            storage.write(key: 'userId', value: jwt['userId']);
            storage.write(key: 'token', value: jwt['token']);
            return true;
          }else{
            print('request failed !!!!!!!!!!!!!!!!');
            return false;
        }
    }catch(error){
      print(error.toString());
    }
  }

   
}