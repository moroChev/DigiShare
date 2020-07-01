import 'package:MyApp/core/services/publication_service/pub_settings_Src.dart';
import 'package:MyApp/core/enum/PostSettingsEnum.dart';
import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/ui/views/home_view.dart';
import 'package:MyApp/ui/views/to_post_view.dart';
import 'package:MyApp/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PostSettingsModel extends BaseModel{

  PublicationSettingService _postSettingSrc = locator<PublicationSettingService>();  
  SETTINGCHOICES _choices;
  BuildContext   _context;
  Publication    _publication;
  Employee       _poster;
  Employee       _user;
  
  SETTINGCHOICES get choices     => this._choices;
  Publication    get publication => this._publication;
  Employee       get poster      => this._poster;
  Employee       get user        => this._user;



  initData(Publication publication, Employee poster, Employee user, BuildContext context){
    this._publication = publication;
    this._poster      = poster;
    this._user        = user;
    this._context     = context;
  }


List<PopupMenuItem<SETTINGCHOICES>> listOfChoices(){

    List<PopupMenuItem<SETTINGCHOICES>> mychoices = [
           PopupMenuItem(value: SETTINGCHOICES.HIDE,child: Text("Masquer"),)
       ];

if(this._poster.id == this._user.id){

  mychoices.addAll([
          PopupMenuItem(value: SETTINGCHOICES.MODIFY,child: Text("Modifier",style: TextStyle(fontFamily: "Times"))),
          PopupMenuItem(value: SETTINGCHOICES.REMOVE,child: Text("Supprimer",style: TextStyle(fontFamily: "Times")))
          ]);
  }

if(this._user.canApprove && this._user.agency.id == this._poster.agency.id){
  if(this._publication.isApproved){
     mychoices.add(PopupMenuItem(value: SETTINGCHOICES.APPROVE,child: Text("Disapprouver",style: TextStyle(fontFamily: "Times"))));
  }else{
     mychoices.add(PopupMenuItem(value: SETTINGCHOICES.APPROVE,child: Text("Approuver",style: TextStyle(fontFamily: "Times"))));
  }
}
    return mychoices;
} 



void applySettings(SETTINGCHOICES choice){

  switch(choice){
    case SETTINGCHOICES.APPROVE  : { print("Approuver est appelé"); approvePublication(); } break;
    case SETTINGCHOICES.REMOVE   : { print("remove est appelé")   ; removePublication();  } break;
    case SETTINGCHOICES.MODIFY   : { print("modify est appelé")   ; modifyPublication(); } break;
    case SETTINGCHOICES.HIDE     : { print("hide est appeale")    ;    } break;
  }

}


void removePublication() async {
  
 Navigator.pop(this._context);
 Navigator.push(this._context, MaterialPageRoute(builder: (context) => HomeView()));
 
 bool isRemoved = await this._postSettingSrc.deletePublication(this._publication.id);

 print("isRemoved : $isRemoved");

}

void approvePublication() async {
 print('the post Before isApproved : ${this.publication.isApproved}');
  this._publication.isApproved = ! this.publication.isApproved;
  print('the post After isApproved : ${this.publication.isApproved}');
  bool isApp = await this._postSettingSrc.approvePublication(this._publication.id, this._publication.isApproved, this._user.id);
   notifyListeners();
  print("is Approved : $isApp");                     
}

void modifyPublication() async {
  Navigator.pop(this._context);
 Navigator.push(this._context, MaterialPageRoute(builder: (context) => ToPostView(post: this._publication))); 
}

void hidePublication(String idPublication) async {
  /// will be added soon
}

 
}