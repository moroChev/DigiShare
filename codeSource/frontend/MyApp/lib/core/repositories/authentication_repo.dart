import '../models/employee.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthenticationRepo{
  static const endpoint = 'http://192.168.43.107:3000/api/auth';

  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<Employee> attemptLogIn(String login, String password) async {
    String url = "$endpoint/login";
    Map body = {'login': login, 'password': password};
    var res = await http.post(url, body: jsonEncode(body),headers: { 'Content-type': 'application/json'});
    if(res.statusCode == 200 || res.statusCode==201)
    {
      print('${this.runtimeType.toString()}:---> authenticated successfully');
      Map jwt = jsonDecode(res.body);
      storage.write(key: 'userId', value: jwt['user']['_id']);
      storage.write(key: 'token', value: jwt['token']);
      return Employee.fromJsonWithPostsIdAndAgency(jwt['user']);
    }else{
      print('${this.runtimeType.toString()}:---> login request failed !!!!!!!!!!!!!!!!');
      return null;
    }
  }

}