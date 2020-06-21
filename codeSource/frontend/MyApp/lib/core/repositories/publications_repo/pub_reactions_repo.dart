import 'dart:convert';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/locator.dart';
import 'package:http/http.dart' as http;
import 'package:MyApp/core/repositories/publications_repo/pub_utility_repo.dart';



class PublicationReactionsRepo{
 

  PubUtilityRepo _pubRepoUtility = locator<PubUtilityRepo>();

  
  Future<bool> addLikePublication(String publicationId, Map body) async {
   String url      = "${this._pubRepoUtility.pubUrl}/$publicationId/likes";
   Map header      = await this._pubRepoUtility.header(); 
   final response  = await http.post(url,body: jsonEncode(body),headers: header);
   print(response.statusCode);
   if(response.statusCode==201 || response.statusCode==200){
      print('Like added !');
      return true;
   }else{
      print("erreur in liking the publication ...");
      return false;
   }
 }


   Future<bool> removeLikePublication(String publicationId) async {
    String url     = "${this._pubRepoUtility.pubUrl}/$publicationId/likes";
    Map header     = await this._pubRepoUtility.header();
    final response = await http.delete(url, headers: header);
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Like removed !');
      return true;
    } else {
      print("erreur in liking the publication ...");
      return false;
    }
  }

  Future<Publication> getPublicationLikes(String publicationId) async {
    String url     = "${this._pubRepoUtility.pubUrl}/$publicationId/likes";
    Map header     = await this._pubRepoUtility.header();
    final response = await http.get(url, headers: header);
    print(response.statusCode);
    try {
      if (response.statusCode == 201 || response.statusCode == 200) {
        return this._pubRepoUtility.parsePublicationsLikes(response.body);
      } else {
        throw Exception('Failed to load publications Data');
      }
    } catch (err) {
      return new Publication();
    }
  }

}