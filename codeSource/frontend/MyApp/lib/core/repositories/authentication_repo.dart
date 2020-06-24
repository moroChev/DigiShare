import '../models/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthenticationRepo{
  static const endpoint = 'http://192.168.43.107:3000/api/auth';
  SharedPreferences storage;

  Future<Employee> attemptLogIn(String login, String password) async {
    String url = "$endpoint/login";
    Map body = {'login': login, 'password': password};
    var res = await http.post(url, body: jsonEncode(body),headers: { 'Content-type': 'application/json'});
    if(res.statusCode == 200 || res.statusCode==201)
    {
      print('${this.runtimeType.toString()}:---> authenticated successfully');
      Map jwt = jsonDecode(res.body);
      storage = await SharedPreferences.getInstance();
      storage.setString('token', jwt['token']);
      storage.setString('userId', jwt['user']['_id']);
      return Employee.fromJsonWithPostsIdAndAgency(jwt['user']);
    }else{
      print('${this.runtimeType.toString()}:---> login request failed !!!!!!!!!!!!!!!!');
      return null;
    }
  }

}