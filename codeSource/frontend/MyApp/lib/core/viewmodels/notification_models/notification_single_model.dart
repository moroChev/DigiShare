
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
  bool _isHidden;
  

  String get notifText => this.notifContent();
  bool get isHidden => this._isHidden;


  initData(notificationA,context){
    this._isHidden = false;
    this._notification=notificationA;
    this._context=context;
  }

  String notifContent(){
    print(" Notification Type : ${this._notification.notificationType}");
    String text=" ";
    switch (this._notification.notificationType) {
      case 'NEW_PUBLICATION': { text = ' demande l\'approbation de sa publication '+this.publicationText();} break;
      case 'APPROVAL': { text= ' a approuvé votre publication '+this.publicationText();} break;
      case 'LIKE': { text = ' a aimé votre publication '+this.publicationText();} break;
      case 'COMMENT': { text = ' a commenté votre publication '+this.publicationText();} break;
    }
    return text;
  }


 String publicationText() {
    String text = this._notification.publication?.content;
    if (text == null || text.trim().isEmpty) return " ";
    else if(text.length>8)
    return ': « '+text.substring(0,8) + '...';
    else
    return ': « $text »‎ .';
  }
  
    
  /// onTap notification tile we want to redirect the user to a screen
  void onTap() {
    switch (this._notification.notificationType) {
      case 'NEW_PUBLICATION': redirectToPost(); break;
      case 'APPROVAL': redirectToPost(); break;
      case 'LIKE': redirectToPost(); break;
      case 'COMMENT': redirectToPost(); break;
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
    case NOTIFICATIONSETTING.REMOVE   : { print("remove est appelé")  ; deleteNotification();   } break;
    case NOTIFICATIONSETTING.HIDE     : { print("hide est appeale")    ;    } break;
  }

}

redirectToPost()async{
//Navigator.pop(this._context);
Navigator.pushNamed(this._context, '/SinglePostView',arguments: this._notification.publication?.id);
 bool result = await this._notifSrv.putNotifAsChecked(this._notification.id);
 this._notification.isChecked = result;
 notifyListeners();
}


deleteNotification() async {
bool result = await this._notifSrv.deleteNotification(this._notification.id);
this._isHidden = result;
print('is Hidden : $isHidden and result $result');
notifyListeners();
}


  
  }