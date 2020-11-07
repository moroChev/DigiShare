import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/repositories/publications_repo/pub_reactions_repo.dart';
import 'package:MyApp/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MyApp/core/models/comment.dart';
import 'package:MyApp/core/repositories/socket_repo.dart';

class PublicationReactionsService {
  PublicationReactionsRepo _postReactions = locator<PublicationReactionsRepo>();
  SocketRepo _socket = locator<SocketRepo>();


  initSocket(Function onCommentCallBack) async {
    await this._socket.setOnNotificationReceived(onCommentReceived, onCommentCallBack);
  }
  // SharedPreferences api
  SharedPreferences storage;

  Future<String> userId() async {
    storage = await SharedPreferences.getInstance();
    return storage.getString('userId');
  }


  void addLike(String postId) async {
    String userId = await this.userId();
    Map body = {"idEmployee": userId};
    bool isAdded = await _postReactions.addLikePublication(postId, body);
    if (isAdded) {
      print("like is added");
    } else {
      print("like isn't added there is an error ...");
    }
  }

  void removeLike(String postId) async {
    bool isRemoved = await _postReactions.removeLikePublication(postId);
    if (isRemoved) {
      print("like is removed");
    } else {
      print("like isn't removed there is an error");
    }
  }

  Future<Publication> getLikes(String publicationId) async {
    Publication publication =
        await this._postReactions.getPublicationLikes(publicationId);
    return publication;
  }

  ///////////////////// Comments //////////////////// 


  Future<List<Comment>> getComments(String publicationId) async {
    try {
      List<Comment> comments = await this._postReactions.getComments(publicationId);
      return comments;
    } catch (e) {
      throw(e);
    }

  }

  Future<bool> addComment(String publicationId,Comment comment) async {
    
      bool isAdded = await this._postReactions.addComment(publicationId, comment);
      return isAdded;
  }

  Future<bool> editComment(String publicationId,Comment comment) async {
    print('${this.runtimeType.toString()} $publicationId and $comment');
      bool isEdited = await this._postReactions.editComment(publicationId, comment);
      return isEdited;

  }

  Future<bool> deleteComment(String publicationId ,String commentId) async {
    //String commentId = comment.id;
    bool isDeleted = await this._postReactions.deleteComment(publicationId,commentId);
    return isDeleted;
  }

  void onCommentReceived(data,callback){
    
    print('${this.runtimeType.toString()} OnReceived comment reteched');
    Comment comment = Comment.fromJson(data);
    print('${this.runtimeType.toString()} i reveived a $comment');
    callback(comment);   
  }



}
