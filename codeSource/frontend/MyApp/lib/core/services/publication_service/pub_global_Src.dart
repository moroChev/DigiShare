import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/repositories/publications_repo/pub_global_repo.dart';
import 'package:MyApp/locator.dart';
import 'dart:io';

class PublicationGlobalService {


  PublicationGlobalRepo    _postGlobal    = locator<PublicationGlobalRepo>();


  Future<List<Publication>> fetchAllPosts() async {
    print("Pub Service : fetchAllPosts .... ");
    var posts = await _postGlobal.fetchPublications();
    var hasData = posts != null;
    if (hasData)
      print(
          '${this.runtimeType.toString()}:---> agency data fetched successfully');
    else
      print('${this.runtimeType.toString()}:---> Failed to load Agency Data');
    return posts;
  }

  Future<Publication> fetchSinglePost(String publicationId) async {
    try {
      Publication pub = await this._postGlobal.getSinglePublication(publicationId);
      return pub;
    } catch (e) {
      throw(e);
    }
  }


  
  Future<bool> postPublication({Publication publication,File image}) async {
      try{
      bool result = await this._postGlobal.createPublication(publication: publication,image: image);
      return result;
      }catch(e){
        print(e);
        return false;
      }
  }



}
