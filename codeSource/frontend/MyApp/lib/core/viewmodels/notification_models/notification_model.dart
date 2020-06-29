
import 'package:MyApp/core/services/notificationsService.dart';
import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:MyApp/locator.dart';
import 'package:MyApp/core/models/notification.dart';
import 'package:MyApp/core/enum/viewstate.dart';

class NotificationModel extends BaseModel{

  final NotificationService _notifSrv = locator<NotificationService>();
  List<Notification> _notifications;
  int _notSeenNotifCount;
  

  List<Notification>  get notifications => this._notifications;
  int get notSeenNotifCount => this._notSeenNotifCount;

 
  Future getNotSeenNotifications() async {
    setState(ViewState.Busy);
    this._notifications = await this._notifSrv.getNotSeenNotifs();
    this._notSeenNotifCount = this._notifications.length;
    print('get not Seen Notif from notifModel Hey ! ');
    setState(ViewState.Idle);  
  }


  Future getAllnotifications() async {
    setState(ViewState.Busy);
    this._notifications = await this._notifSrv.getNotification();
    setState(ViewState.Idle);
  }

  markAsSeenAllNotSeen(){
    this._notSeenNotifCount = 0;
    notifyListeners();
    this._notifSrv.putAllNotifsAsSeen();
  }

}