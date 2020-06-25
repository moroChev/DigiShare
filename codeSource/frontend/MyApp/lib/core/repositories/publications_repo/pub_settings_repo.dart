import 'dart:convert';
import 'dart:io';
import 'package:MyApp/core/models/publication.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:MyApp/core/repositories/publications_repo/pub_utility_repo.dart';
import 'package:MyApp/locator.dart';


class PublicationSettingsRepo{


  PubUtilityRepo _pubRepoUtility = locator<PubUtilityRepo>();


  Future<bool> deletePublication(String publicationId) async {
    String url = "${this._pubRepoUtility.pubUrl}/$publicationId";
    Map header = await this._pubRepoUtility.header();
    final response = await http.delete(url, headers: header);
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('removed !');
      return true;
    } else {
      print("erreur in liking the publication ...");
      return false;
    }
  }

  Future<bool> approvePublication(String publicationId, bool isApproved, String approvedBy) async {
    String url = "${this._pubRepoUtility.pubUrl}/$publicationId/approve";
    Map header = await this._pubRepoUtility.header();
    Map<String, dynamic> body = {
      "isApproved": isApproved,
      "approvedBy": approvedBy
    };
    final response = await http.post(url, body: jsonEncode(body), headers: header);
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('aproved added !');
      return true;
    } else {
      print("erreur in liking the publication ...");
      return false;
    }
  }



  Future<bool> modifyPublication({Publication publication,File image}) async {

    Map<String, String> header = await this._pubRepoUtility.headerMultiPart();

     var uri = Uri.parse("${this._pubRepoUtility.pubUrl}/${publication.id}");

     var request = http.MultipartRequest('PUT',uri)
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