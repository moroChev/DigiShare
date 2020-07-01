import 'package:flutter/material.dart';
import 'package:strings/strings.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_image.dart';
import 'package:MyApp/core/models/notification.dart' as myNotification;
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/core/viewmodels/notification_models/notification_single_model.dart';
import 'package:MyApp/core/enum/notificationType.dart';
import 'package:intl/intl.dart';


class NotificationTile extends StatelessWidget {

  final myNotification.Notification notification;
  
  NotificationTile({@required this.notification});

  @override
  Widget build(BuildContext context) {
    
     return BaseView<SingleNotificationModel>(
              onModelReady: (model)=>model.initData(this.notification, context),
              builder:(context,model,child)=> model.isHidden ? 
              Container(height: 0,width: 0,) 
              :Ink(
                color: notification.isChecked ? Colors.white : Color(0xFFE5F2FA),
                child:  Column(
                  children: <Widget>[
                    ListTile(
                      leading: EmployeeImage(imageUrl: this.notification.notifier.imageUrl),
                      title: notificationContent(model),
                      subtitle: Text(DateFormat('EEE hh:mm aaa').format(this.notification.date)),
                      isThreeLine: true,
                      onTap: () => model.onTap(),
                      trailing: notificationSettings(model),
                    ),
                    Divider(
                      indent: 80,
                    ),
                  ],
                ),
              ),
    );
  }


Widget notificationContent(SingleNotificationModel model){
  return RichText(
                text: TextSpan(
                  style: new TextStyle(color: Colors.black, fontFamily: "Times"),
                  children: <TextSpan>[
                    TextSpan(text: capitalize(notification.notifier.firstName +' ' +notification.notifier.lastName),style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: model.notifText),
                  ],
                ),
          );
}


Widget notificationSettings(SingleNotificationModel model){
  return PopupMenuButton<NOTIFICATIONSETTING>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          icon: Icon(Icons.more_horiz),
          onSelected: model.applySettings,
          itemBuilder: (BuildContext context){
            return model.listOfChoices();
          }
  );
}





 
}
