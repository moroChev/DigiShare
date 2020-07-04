import 'dart:convert';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/models/comment.dart';
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

  /*  
 router.get('/:id/comments', commentController.getAllComments);
 router.post('/:id/comments',commentController.addComment);
 router.put('/:id/comments/:commentId',commentController.editComment);
 router.delete('/:id/comments/:commentId',commentController.deleteComment);
  */


  Future<List<Comment>> getComments(String publicationId) async {
    String url     = "${this._pubRepoUtility.pubUrl}/$publicationId/comments";
    Map header     = await this._pubRepoUtility.header();
    final response = await http.get(url, headers: header);
    if(response.statusCode==200){
      return this._pubRepoUtility.parseComments(response.body);
    }else{
      throw Exception('Failed to load Comments Data');
    }
  }

  Future<bool> addComment(String publicationId,Comment comment) async {
    String url = "${this._pubRepoUtility.pubUrl}/$publicationId/comments";
    Map header = await this._pubRepoUtility.header();
    Map body   = {
      "text": comment.text,
      "commentator":comment.commentator.id,
    };
    final response = await http.post(url, body: jsonEncode(body),headers: header);
    if(response.statusCode==201)
       return true;
    else
       throw false;
  }

  Future<bool> editComment(String publicationId,Comment comment) async {
    String url     = "${this._pubRepoUtility.pubUrl}/$publicationId/comments/${comment.id}";
    Map header     = await this._pubRepoUtility.header();
    Map body = {
      "text": comment.text,
      "commentator":comment.commentator.id,
    };
    final response = await http.put(url, body: jsonEncode(body), headers: header);
    if(response.statusCode==201 || response.statusCode==200)
       return true;
    else
       throw false;
  }  

  Future<bool> deleteComment(String publicationId, String commentId) async {
    String url     = "${this._pubRepoUtility.pubUrl}/$publicationId/comments/$commentId";
    Map header     = await this._pubRepoUtility.header();
    final response = await http.delete(url, headers: header);
    if(response.statusCode==201 || response.statusCode==200)
       return true;
    else
       throw false;
  } 

}