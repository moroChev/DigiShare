import 'dart:convert';
import 'dart:io';
import 'package:MyApp/core/models/publication.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:MyApp/core/repositories/publications_repo/pub_utility_repo.dart';
import 'package:MyApp/locator.dart';



class PublicationGlobalRepo{


PubUtilityRepo _pubRepoUtility = locator<PubUtilityRepo>();


Future<List<Publication>> fetchPublications() async {
    Map header     = await this._pubRepoUtility.header();
    final response = await http.get(this._pubRepoUtility.pubUrl, headers: header);
    List<Publication> posts ;
    if (response.statusCode == 200) {
      posts= this._pubRepoUtility.parsePublications(response.body);
    } 
    return posts;
  }

Future<Publication> getSinglePublication(String publicationId) async {
  Map header = await this._pubRepoUtility.header();
  String url = '${this._pubRepoUtility.pubUrl}/$publicationId'; 
  final response = await http.get(url,headers: header);
  Publication post;
  if(response.statusCode==200){
    Map pub = jsonDecode(response.body);
    print('aprés avoir fetché la single post here we are going to parse that $pub');
    post = Publication.fromJson(pub);
  }
  return post;
} 

  
Future<bool> createPublication({ Publication publication, File image}) async {
    Map<String, String> header = await this._pubRepoUtility.headerMultiPart();
    var  uri = Uri.parse(this._pubRepoUtility.pubUrl);
     var request = http.MultipartRequest('POST',uri,)
      ..fields['content'] = publication.content
      ..fields['postedBy'] = publication.postedBy.id
      ..headers.addAll(header);
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('imageUrl', image.path, contentType: MediaType('image', 'jpg')));
    } 
    var response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Uploaded!');
      return true;
    } else {
      print("erreur in sending the publication ...");
      return false;
    }
  }




}