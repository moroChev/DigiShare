import 'package:MyApp/core/repositories/publications_repo/pub_settings_repo.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/locator.dart';
import 'dart:io';


class PublicationSettingService{
  

  PublicationSettingsRepo _publicationSettingsRepo = locator<PublicationSettingsRepo>();

  
  Future<bool> approvePublication(String publicationId,bool isApproved, String userId)async{
    try {
      bool result = await _publicationSettingsRepo.approvePublication(publicationId, isApproved, userId);
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }


 Future<bool> deletePublication(String publicationId) async {
    try {
      bool result = await _publicationSettingsRepo.deletePublication(publicationId);
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }


  Future<bool> modifyPublication({Publication publication,File image}) async {
   try{ 
    bool result = await _publicationSettingsRepo.modifyPublication(publication: publication,image: image);
    return result;
    }catch (e) {
      print(e);
      return false;
    }
  }

}