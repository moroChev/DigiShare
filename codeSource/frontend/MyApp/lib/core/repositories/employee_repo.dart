import 'dart:convert';
import 'dart:io';
import 'package:MyApp/core/models/publication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:MyApp/core/models/employee.dart';

class EmployeeRepo{

// our API adress
  final String emp_Url         = "${DotEnv().env['API_URL']}/employees";
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

  Future<Employee> fetchProfilData({@required String idEmployee}) async {
      String url     = "$emp_Url/$idEmployee";
      Map header     = await this.header();
      final response = await http.get(url, headers: header);
      if (response.statusCode == 200) {
        return Employee.fromJsonWithPostsAndAgencyObjects(
            json.decode(response.body));
      } else {
        throw Exception('Failed to load Profil Data');
      }
  }

  Future<List<Publication>> fetchProfilPublications({@required String idEmployee}) async {
    Map header     = await this.header();
    String url     = "$emp_Url/$idEmployee/Publications";
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      return compute(parsePublications, response.body);
    } else {
      throw Exception('Failed to load Profil Data');
    }
  }

  
Future<List<Employee>> getEmployeesForSuggestions() async {
  Map header        = await this.header();
  final response    = await http.get(emp_Url,headers: header); 
  if (response.statusCode == 200 || response.statusCode == 201) {
      return compute(parseEmployee, response.body);
    } else {
      throw Exception('Failed to load search Data');
    }

}

   Future<List<Employee>> searchQuery(String keyword) async {
    String url              = "$emp_Url/search";
    Map<String,String> body = { "firstName": keyword };
    Map header              = await this.header();
    final response          = await http.post(url, body: jsonEncode(body), headers: header);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return compute(parseEmployee, response.body);
    } else {
      throw Exception('Failed to load search Data');
    }
  }





}

List<Publication> parsePublications(String response) {
  List<dynamic> list = jsonDecode(response);
  try {
    List<Publication> myList =
        list.map((e) => Publication.fromJson(e)).toList();

    print('Publications parsed ....... a sample : ${myList[0].toString()} ');
    return myList;
  } catch (err) {
    print(err.toString());
    return list;
  }
}


List<Employee> parseEmployee(String response) {
  List<dynamic> list = jsonDecode(response);
  try {
    
    List<Employee> myList =
        list.map((e) => Employee.fromJsonWithPostsIdAndAgency(e)).toList();

    print('Publications parsed ....... a sample : ${myList[0].toString()} ');
    return myList;
  } catch (err) {
    print(err.toString());
    return list;
  }
}