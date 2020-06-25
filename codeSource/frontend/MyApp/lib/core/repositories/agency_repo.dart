import '../models/agency.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io'; //HttpHeaders access to add the authorization header
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AgencyRepo{
  final endpoint = "${DotEnv().env['API_URL']}/agencies";
  // SharedPreferences api
  SharedPreferences storage;

  Future<Map<String,String>> header() async {
    storage = await SharedPreferences.getInstance();
    String token = storage.getString('token');
    Map<String,String> header    = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader  : 'application/json'
    };
    return header;
  }

  // Method to fetch agency's data without employees and subsidiaries
  Future<Agency> fetchAgencyInfoOnly(String id) async {
    Map header = await this.header();
    String url = "$endpoint/$id";
    var response = await http.get(url, headers: header);
    var agency;
    if(response != null)
      agency = Agency.fromJsonWithIdsInLists(json.decode(response.body)['agency']);
    return agency;
  }

  // Method to fetch agency's data with employees and subsidiaries
  Future<Agency> fetchAllAgencyData(String id) async {
    Map header = await this.header();
    String url = "$endpoint/$id";
    var response = await http.get(url, headers: header);
    var agency;
    if(response != null)
      agency = Agency.fromJsonWithObjectsInLists(json.decode(response.body)['agency']);
    return agency;
  }

  Future<List<Agency>> fetchAllAgencies() async {
    Map header = await this.header();
    String url = endpoint;
    var response = await http.get(url, headers: header);
    var agencies;
    if(response != null)
      agencies = (json.decode(response.body) as List)?.map((agency) => Agency.fromJsonWithIdsInLists(agency))?.toList();
    return agencies;
  }

}