import '../models/agency.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:io'; //HttpHeaders access to add the authorization header
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AgencyRepo{
  final String endpoint = '${DotEnv().env['API_URL']}/agencies';
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