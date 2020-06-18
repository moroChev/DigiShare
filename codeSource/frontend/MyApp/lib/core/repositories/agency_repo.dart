import '../models/agency.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:io'; //HttpHeaders access to add the authorization header
import 'dart:convert';

class AgencyRepo{
  static const endpoint = 'http://192.168.43.107:3000/api/agencies';
  // secure storage api
  FlutterSecureStorage storage = FlutterSecureStorage();

  // Method to fetch agency's data without employees and subsidiaries
  Future<Agency> fetchAgencyInfoOnly(String id) async {
    String token = await storage.read(key: 'token');
    String url = "$endpoint/$id";
    var response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    var agency;
    if(response != null)
      agency = Agency.fromJsonWithIdsInLists(json.decode(response.body)['agency']);
    return agency;
  }

  // Method to fetch agency's data with employees and subsidiaries
  Future<Agency> fetchAllAgencyData(String id) async {
    String token = await storage.read(key: 'token');
    String url = "$endpoint/$id";
    var response = await http.get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    var agency;
    if(response != null)
      agency = Agency.fromJsonWithObjectsInLists(json.decode(response.body)['agency']);
    return agency;
  }

}