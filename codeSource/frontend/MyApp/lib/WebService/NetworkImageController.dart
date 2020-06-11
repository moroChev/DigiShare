import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io'; //HttpHeaders access to add the authorization header

class NetworkImageController{

  // secure storage api
  static FlutterSecureStorage storage = FlutterSecureStorage();

  // Method to fetch images from the api and return them in NetworkImage type so we can use them as background images to our widgets or as Image widgets
  // We need this method because the api restrict access to it's data only to the authenticated users for security purposes
  static Future<NetworkImage> fetchImage(String imageUrl) async {
    String token = await storage.read(key: 'token');
    print("token from network image controller $token");
    return NetworkImage(imageUrl, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  }

  
}