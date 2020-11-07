//import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:MyApp/core/repositories/publications_repo/pub_utility_repo.dart';
import 'package:MyApp/locator.dart';
import 'package:MyApp/core/models/notification.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepo{
  
 PubUtilityRepo _pubUtility = locator<PubUtilityRepo>();
 final String _notificationUrl = "${DotEnv().env['API_URL']}/notifications";
   // SharedPreferences api
  SharedPreferences storage;

  

Future<List<Notification>> getNotifications() async {
   Map header = await this._pubUtility.header();
   String url = this._notificationUrl;
   final response  = await http.get(url,headers: header);
   if(response.statusCode == 200){
     return parseNotifications(response.body);
   } else{
     throw Exception('Failed to load Notifications Data');
   }
 }

 Future putAllNotifsAsSeen() async {
   Map header = await this._pubUtility.header();
   String url = this._notificationUrl;
   final response  = await http.put(url,headers: header);
   return isResponseOk(response);
 }

 Future putNotifAsChecked(notifId) async {
   Map header = await this._pubUtility.header();
   String url = '${this._notificationUrl}/$notifId';
   http.Response response  = await http.put(url,headers: header);
   return isResponseOk(response);
 }

 Future deleteNotification(notifId) async {
   Map header = await this._pubUtility.header();
   String url = '${this._notificationUrl}/$notifId';
   http.Response response  = await http.delete(url,headers: header);
   return isResponseOk(response);
 }

 Future deleteAllNotifications() async {
   Map header = await this._pubUtility.header();
   String url = this._notificationUrl;
   final response  = await http.delete(url,headers: header);
   return isResponseOk(response);
 }

  bool isResponseOk(http.Response response){
    if(response.statusCode == 200){
        return true;
      } else{
        return false;
      }
  }

 List<Notification> parseNotifications(String responseBody){
   List<dynamic> list = jsonDecode(responseBody);
   List<Notification> mylist =list.map((e) => Notification.fromJson(e)).toList();
   mylist.forEach((element) {print(element);});
   return mylist;
 }


 

}