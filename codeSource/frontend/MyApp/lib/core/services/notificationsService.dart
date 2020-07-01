import 'package:MyApp/core/models/notification.dart' as myNotification;
import 'package:MyApp/core/repositories/socket_repo.dart';
import 'package:MyApp/core/repositories/notifications_repo/notifications_repo.dart';
import 'package:MyApp/locator.dart';

class NotificationService{

  final NotificationRepo notifRepo = locator<NotificationRepo>();
  
  SocketRepo _socket = locator<SocketRepo>();


  initSocket(Function onNotificationCallBack) async {
    await this._socket.setOnNotificationReceived(onNotificationReceived, onNotificationCallBack);
  }

  Future getNotifications() async {
    List<myNotification.Notification> notifs = await notifRepo.getNotifications();
    return notifs;
  }
  
  Future getNotSeenNotifs() async {
    List<myNotification.Notification> notifs = await notifRepo.getNotifications();
    List<myNotification.Notification> notSeen =  notifs.where((notif) => !notif.isSeen).toList();
    return notSeen.length;
  }

  Future putAllNotifsAsSeen() async {
    bool result = await notifRepo.putAllNotifsAsSeen();
    return result;
  }

  Future putNotifAsChecked(String notificationId) async {
    bool result = await this.notifRepo.putNotifAsChecked(notificationId);
    return result;
  }

  Future deleteNotification(notifId) async {
    bool result = await this.notifRepo.deleteNotification(notifId);
    return result;
  }

  void onNotificationReceived(data,callback){
    
    print('${this.runtimeType.toString()} i reveived something Before');
    myNotification.Notification notification = myNotification.Notification.fromJson(data);
    print('${this.runtimeType.toString()} i reveived something $notification');
    callback(notification);   
  }

}