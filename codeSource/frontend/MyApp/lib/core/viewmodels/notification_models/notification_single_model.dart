
import 'package:MyApp/core/services/notificationsService.dart';
import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:MyApp/locator.dart';
import 'package:flutter/material.dart';
import 'package:MyApp/core/models/notification.dart' as myNotification ;

import 'package:MyApp/core/enum/notificationType.dart';

class SingleNotificationModel extends BaseModel{

  final NotificationService _notifSrv = locator<NotificationService>();
  myNotification.Notification _notification;
  BuildContext _context;
  final Map<String, String> _notifText = {
    'NEW_PUBLICATION':
        ' a publié une nouvelle publication et demande son approbation',
    'APPROVAL': ' a approuvé votre publication'
  };

  String get notifText => this._notifText[this._notification.notificationType];


  initData(notification,context){
    this._notification=notification;
    this._context=context;
  }
  
    
  
  void onTap() {
    switch (this._notification.notificationType) {
      case 'NEW_PUBLICATION': redirectToPost(); break;
      case 'APPROVAL': redirectToPost(); break;
    }
  }


  
List<PopupMenuItem<NOTIFICATIONSETTING>> listOfChoices(){

    List<PopupMenuItem<NOTIFICATIONSETTING>> mychoices = [
           PopupMenuItem(value: NOTIFICATIONSETTING.REMOVE,child: Text("Supprimer"),)
       ];
    return mychoices;
} 




void applySettings(NOTIFICATIONSETTING choice){

  switch(choice){
    case NOTIFICATIONSETTING.REMOVE   : { print("remove est appelé")   ;   } break;
    case NOTIFICATIONSETTING.HIDE     : { print("hide est appeale")    ;    } break;
  }

}

redirectToPost()async{
Navigator.pushNamed(this._context, '/SinglePostView',arguments: this._notification.publication?.id);
 bool result = await this._notifSrv.putNotifAsChecked(this._notification.id);
 print("is puted Checked : $result");
}


  
  }