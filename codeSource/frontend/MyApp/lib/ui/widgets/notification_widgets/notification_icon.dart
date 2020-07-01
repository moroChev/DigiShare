import 'package:MyApp/core/enum/viewstate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/core/viewmodels/notification_models/notification_model.dart';


class NotificationIcon extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
print('Notification Icon ');
    return BaseView<NotificationModel>(
      onModelReady: (model) => model.getNotSeenNotifications(),
      builder: (context, model, child) =>  InkWell(
        onTap:() {
           model.markAsSeenAllNotSeen();
           Navigator.pushNamed(context, '/Notifications');},  
        child: Container(
          width: 50,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ViewState.Busy ==  model.state ? 
        CircularProgressIndicator()
        :
        Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.solidBell),
                ],
              ),
              model.notSeenNotifCount > 0 ? 
              Positioned(
                top: 4.0,
                right: -1.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red[200]),
                  alignment: Alignment.center,
                  child: Text('${model.notSeenNotifCount}',style: TextStyle(color: Colors.white,fontSize: 10),),
                ),
              ):
              Container(height:0,width:0),
            ],
          ),
        ),
      ),
    );
  }
}