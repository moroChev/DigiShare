import 'package:MyApp/entities/Employee.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../entities/Employee.dart';

class AuthController{
   static String API_URL_AUTH = "http://localhost:3000/api/auth";
   static FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<Employee> attemptLogIn(String login, String password) async {

    String url    = "$API_URL_AUTH/login";
    Map body      = {
                    'login': login,
                    'password': password
                  };      
           print("$login and $password");               
    final res = await http.post(url, body: jsonEncode(body),headers: { 'Content-type': 'application/json'});
        if(res.statusCode == 200 || res.statusCode==201)

          {
            Map jwt = jsonDecode(res.body);
            print('storage Ok and request ok yes : '+res.body);
            setEmployeeInStorage(jwt);
            print("every thing is okay wa have the response ..");
            return Employee.fromJsonWithPostsIdAndAgency(jwt['user']);

          }else{
            print('request failed !!!!!!!!!!!!!!!!');
              return null;
          }
                
  }

  //method to check if the user is authenticated
   static Future<bool> checkAuth() async {
     String isAuthenticated = await storage.read(key: 'userId');
     return (isAuthenticated != null);
   }

   //method to attempt logout and clear the user data
   static void attemptLogOut() async {
     storage.deleteAll();
   }


   static setEmployeeInStorage(Map<String,dynamic> jwt) {
      storage.write(key: 'userId', value: jwt['user']['_id']);
      storage.write(key: 'token', value: jwt['token']);
  }








   
}