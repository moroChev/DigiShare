import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io'; //HttpHeaders access to add the authorization header

class NetworkImageRepo{
  // SharedPreferences api
  SharedPreferences storage;

  // Method to fetch images from the api and return them in NetworkImage type so we can use them as background images to our widgets or as Image widgets
  // We need this method because the api restrict access to it's data only to the authenticated users for security purposes
  Future<NetworkImage> fetchImage(String imageUrl) async {
    storage = await SharedPreferences.getInstance();
    String token =  storage.getString('token');
    return NetworkImage(imageUrl, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
  }
}