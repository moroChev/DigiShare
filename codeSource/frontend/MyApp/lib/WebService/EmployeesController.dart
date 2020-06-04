import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../entities/Employee.dart';
import 'package:flutter/foundation.dart';
import '../entities/Publication.dart';

class EmployeesController {
  static final String API_URL = "http://localhost:3000/api/employees";
  // secure storage api
  static FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<Employee> fetchProfilData({String id}) async {
    print("fetch profil data calleed ............. $id");
  
      String token = await storage.read(key: 'token');
      String url = "$API_URL/$id";
      final response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

      if (response.statusCode == 200) {
        print("request has been successedd ... ");
        return Employee.fromJsonWithPostsAndAgencyObjects(
            json.decode(response.body));
      } else {
        print('failed to get data Profil data');
        throw Exception('Failed to load Profil Data');
      }
  }

  static Future<List<Publication>> fetchProfilPublications(String id) async {
    String token = await storage.read(key: 'token');
    String url = "$API_URL/$id/Publications";
    final response = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

    if (response.statusCode == 200) {
      print("request has been successedd ... ");
      return compute(parsePublications, response.body);
    } else {
      throw Exception('Failed to load Profil Data');
    }
  }
}

List<Publication> parsePublications(String response) {
  try {
    List<dynamic> list = jsonDecode(response);
    List<Publication> myList =
        list.map((e) => Publication.fromJson(e)).toList();

    print('Publications parsed ....... a sample : ${myList[0].toString()} ');
    return myList;
  } catch (err) {
    print(err.toString());
  }
}
