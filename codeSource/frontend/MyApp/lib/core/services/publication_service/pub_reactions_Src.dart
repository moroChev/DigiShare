import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/repositories/publications_repo/pub_reactions_repo.dart';
import 'package:MyApp/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicationReactionsService {
  PublicationReactionsRepo _postReactions = locator<PublicationReactionsRepo>();
  // SharedPreferences api
  SharedPreferences storage;

  void addLike(String postId) async {
    storage = await SharedPreferences.getInstance();
    String userId = storage.getString('userId');
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
}
