import 'package:MyApp/entities/Employee.dart';
import 'package:flutter/foundation.dart';

import '../entities/Agency.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:io'; //HttpHeaders access to add the authorization header
import 'dart:convert';


class AgenciesController{

  static final String API_URL = "http://localhost:3000/api/agencies";
  // secure storage api
  static FlutterSecureStorage storage = FlutterSecureStorage();

  // Method to fetch agency's data without employees and subsidiaries
  static Future<Agency> fetchAgencyData(String id) async {
    String token = await storage.read(key: 'token');
    String url = "$API_URL/$id";

    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

    if(response.statusCode == 200)
    {
      print("request has been succeeded... ");
      return Agency.fromJsonWithoutEmployeesAndSubsidiaries(json.decode(response.body)['agency']);
    }else{
      throw Exception('Failed to load Agency Data');
    }
  }

  // Method to fetch agency's employees only
  static Future<List<Employee>> fetchAgencyEmployees(String id) async {
    String token = await storage.read(key: 'token');
    String url = "$API_URL/$id";

    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});

    if(response.statusCode == 200)
    {
      print("request has been succeeded... ");
      return compute(parseEmployees,json.decode(response.body)['agency']['employees'] as List);
    }else{
      throw Exception("Failed to load Agency's Employees Data");
    }
  }

  // Helper method serves isolation purpose
  // Invoked inside fetchAgencyEmployees method
  static List<Employee> parseEmployees(List<dynamic> list){
    print('parseEmployees ******************************');
    print(list.toString());
    return list?.map((e) => Employee.fromJsonWithoutPostsAndAgency(e))?.toList();
  }

  // Method to fetch agency's subsidiaries only
  static Future<List<Agency>> fetchAgencySubsidiaries(String id) async {
    String token = await storage.read(key: 'token');
    String url = "$API_URL/$id";

    final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}
    );

    if(response.statusCode == 200)
    {
      print("request has been succeeded... ");
      return compute(parseSubsidiaries,json.decode(response.body)['agency']['subsidiaries'] as List);
    }else{
      throw Exception("Failed to load Agency's Subsidiaries Data");
    }
  }

  // Helper method serves isolation purpose
  // Invoked inside fetchAgencySubsidiaries method
  static List<Agency> parseSubsidiaries(List<dynamic> list){
    print('parseSubsidiaries ************************');
    print(list);
    return list?.map((e) => Agency.fromJsonWithoutEmployeesAndSubsidiaries(e))?.toList();
  }
}

