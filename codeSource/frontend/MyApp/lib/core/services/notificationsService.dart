import 'package:MyApp/core/models/notification.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/repositories/notifications_repo/notifications_repo.dart';
import 'package:MyApp/locator.dart';

class NotificationService{

  final NotificationRepo notifRepo = locator<NotificationRepo>();

  Future getNotification() async {
    List<Notification> notifs = await notifRepo.getNotifications();
    return notifs;
  }
  
  Future getNotSeenNotifs() async {
    List<Notification> notifs = await notifRepo.getNotifications();
    print('nbr of all notifs ${notifs.length}');
    List<Notification> notSeen =  notifs.where((notif) => !notif.isSeen).toList();
    return notSeen;
  }

  Future putAllNotifsAsSeen() async {
    bool result = await notifRepo.putAllNotifsAsSeen();
    return result;
  }

  Future putNotifAsChecked(String notificationId) async {
    bool result = await this.notifRepo.putNotifAsChecked(notificationId);
    return result;
  }

}