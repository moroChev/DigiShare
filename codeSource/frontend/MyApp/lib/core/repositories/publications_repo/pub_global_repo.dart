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
    if (response.statusCode == 200) {
      return this._pubRepoUtility.parsePublications(response.body);
    } else {
      throw Exception('Failed to load publications Data');
    }
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