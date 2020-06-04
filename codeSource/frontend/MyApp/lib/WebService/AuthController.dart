import 'package:MyApp/entities/Employee.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../entities/Agency.dart';

class AuthController{
   static String API_URL_AUTH = "http://localhost:3000/api/auth";
   static FlutterSecureStorage storage = FlutterSecureStorage();
  
  static Future<bool> attemptLogIn(String login, String password) async {
    String url = "$API_URL_AUTH/login";
    Map body = {
      'login': login,
      'password': password
    };
    try{
          var res = await http.post(url, body: jsonEncode(body),headers: { 'Content-type': 'application/json'});
          print(res.statusCode);
          if(res.statusCode == 200)
          {
            Map jwt = jsonDecode(res.body);
            print(jwt);
            await setEmployeeInStorage(jwt);
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

  //method to check if the user is authenticated
   static Future<bool> checkAuth() async {
     String isAuthenticated = await storage.read(key: 'userId');
     return (isAuthenticated != null);
   }

   //method to attempt logout and clear the user data
   static void attemptLogOut() async {
     storage.deleteAll();
   }

   static setEmployeeInStorage(Map<String,dynamic> jwt) async {

        Employee employee = Employee.fromJsonWithPostsIdAndAgency(jwt['user']);
        
        print("the employee who is auth is : $employee");
      await storage.write(key: 'userId', value: employee?.id);
      await storage.write(key: 'firstName', value: employee?.firstName);
      await storage.write(key: 'lastName', value: employee?.lastName);
      await storage.write(key: 'imageUrl', value: employee?.imageUrl);
      await storage.write(key: 'email', value: employee?.email);
      await storage.write(key: 'AgencyName', value: employee?.agency?.name );
      await storage.write(key: 'AgencyId', value: employee?.agency?.id);
      await storage.write(key: 'token', value: jwt['token']);

  }


   static Future<Employee> getEmplyeeFromStorage() async {
   String idEmployee   = await storage.read(key: 'userId');
   String firstName  = await storage.read(key: 'firstName');
   String lastName   = await storage.read(key: 'lastName');
   String imageUrl   = await storage.read(key: 'imageUrl');
   String email      = await storage.read(key: 'email');
   String AgencyName = await storage.read(key: 'AgencyName');
   String AgencyId = await storage.read(key: 'AgencyId');
   Agency agency      = Agency(id: AgencyId,name: AgencyName);

   Employee emp = Employee(id: idEmployee, firstName: firstName, lastName: lastName, imageUrl: imageUrl, email: email,agency: agency);
   print("get Employee From Strorage $emp");
   return emp;
  }


   
}