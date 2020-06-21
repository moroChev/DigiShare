import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/repositories/publications_repo.dart';
import 'package:MyApp/locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:MyApp/core/enum/PostSettingsEnum.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class PublicationService {
  PublicationRepo _postApi = locator<PublicationRepo>();
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<List<Publication>> fetchAllPosts() async {
    print("Pub Service : fetchAllPosts .... ");
    var posts = await _postApi.fetchPublications();
    var hasData = posts != null;
    if (hasData)
      print(
          '${this.runtimeType.toString()}:---> agency data fetched successfully');
    else
      print('${this.runtimeType.toString()}:---> Failed to load Agency Data');
    return posts;
  }

  void addLike(String postId) async {
    String userId = await storage.read(key: 'userId');
    Map body = {"idEmployee": userId};
    bool isAdded = await _postApi.addLikePublication(postId, body);
    if (isAdded) {
      print("like is added");
    } else {
      print("like isn't added there is an error ...");
    }
  }

  void removeLike(String postId) async {
    bool isRemoved = await _postApi.removeLikePublication(postId);
    if (isRemoved) {
      print("like is removed");
    } else {
      print("like isn't removed there is an error");
    }
  }

  Future<Publication> getLikes(String publicationId) async {
    Publication publication =
        await this._postApi.getPublicationLikes(publicationId);
    return publication;
  }

  Future<bool> postPublication(
      {@required Publication publication,
      File imageUrl,
      @required RequestChoices requestType}) async {
   print("postPub Service $publication");
return true;
   /*  this._postApi.postPublication(
        publication: publication,
        imageUrl: imageUrl,
        requestType: requestType
      ); */
      
  }
}
