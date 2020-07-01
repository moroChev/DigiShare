
import 'package:MyApp/core/services/notificationsService.dart';
import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:MyApp/locator.dart';
import 'package:MyApp/core/models/notification.dart';
import 'package:MyApp/core/enum/viewstate.dart';

class NotificationModel extends BaseModel{

  final NotificationService _notifSrv = locator<NotificationService>();

  List<Notification> _notifications;
  
  int _notSeenNotifCount;
  

  int get notSeenNotifCount => this._notSeenNotifCount;
  
  List<Notification>  get notifications => this._notifications;



  Future getAllnotifications() async {
    setState(ViewState.Busy);
    this._notifications = await this._notifSrv.getNotifications();
    await this._notifSrv.initSocket(onNotificationReceived);
    print('${this.runtimeType.toString()} getAllNotifs !');
    setState(ViewState.Idle);
  }


 
  Future getNotSeenNotifications() async {
    setState(ViewState.Busy);
    this._notSeenNotifCount = await this._notifSrv.getNotSeenNotifs();
    print('get not Seen Notif from notifModel Hey ! ');
    await this._notifSrv.initSocket(onNotificationReceived);
    setState(ViewState.Idle);  
  }
 

  onNotificationReceived(Notification notif){
    print('${this.runtimeType.toString()} i reveived ${notif.publication} and the list lentgh ${this._notifications?.length}');
    print('${this.runtimeType.toString()} i reveived  NOT SEEN NOTIFS COUNT : $_notSeenNotifCount');
   // if(this._notifications != null  ) this._notifications.insert(0,notif);
    if(this._notifications != null  ) {
      this._notifications.add(notif);
      print('${this.runtimeType.toString()} After adding the notif the lentgh is : ${this._notifications?.length} ');
    }
    if(this._notSeenNotifCount != null ) {
      this._notSeenNotifCount++;
       print('${this.runtimeType.toString()} After receiving the new AND NOT SEEN NOTIFS COUNT : $_notSeenNotifCount');
      }
    notifyListeners();
  }

    markAsSeenAllNotSeen(){
    this._notSeenNotifCount = 0;
    notifyListeners();
    this._notifSrv.putAllNotifsAsSeen();
  }



}