import 'package:MyApp/entities/Employee.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController{
   
   static String API_URL_AUTH = "http://localhost:3000/api/auth";
   static FlutterSecureStorage storage = FlutterSecureStorage();


  
  static Future<bool> attemptLogIn(String login, String password) async {
    String url    = "$API_URL_AUTH/login";
    Map body      = {
                    'login': login,
                    'password': password
                  };
    try{
          var res = await http.post(url, body: jsonEncode(body),headers: { 'Content-type': 'application/json'});
          print(res.statusCode);
          if(res.statusCode == 200 || res.statusCode==201)
          {
            Map jwt = jsonDecode(res.body);
            print(jwt);
            _storageMethod(jwt);
            print('storage Ok and request ok yes : '+res.body);
            return true;
          }else{
            print('request failed !!!!!!!!!!!!!!!!');
            return false;
        }
    }catch(error){
      print(error.toString());
      return false;
    }
  }


   static _storageMethod(Map<String,dynamic> jwt) {

        Employee employee = Employee.fromJsonWithPostsIdAndAgency(jwt['user']);
        print("the employee who is auth is : $employee");
        storage.write(key: 'userId', value: employee?.id);
        storage.write(key: 'firstName', value: employee?.firstName);
        storage.write(key: 'lastName', value: employee?.lastName);
        storage.write(key: 'imageUrl', value: employee?.imageUrl);
        storage.write(key: 'email', value: employee?.email);
        storage.write(key: 'AgencyName', value: employee?.agency?.name );
        storage.write(key: 'token', value: jwt['token']);

  }


   
}