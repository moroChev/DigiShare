import 'package:flutter/material.dart';
import 'package:MyApp/ui/shared/sliverAppBar.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/ui/shared/floatingButton.dart';
import 'package:MyApp/core/viewmodels/notification_models/notification_model.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/ui/widgets/notification_widgets/notification_tile.dart';



class NotificationsView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationModel>(
      onModelReady: (model)=> model.getAllnotifications(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingButton(),
        backgroundColor: Color(0xFFF5F5F8),
        body: CustomScrollView(
          slivers: <Widget>[
            OurSliverAppBar(title: "Notifications"),
            model.state == ViewState.Busy
                ? SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                :
                 model.notifications.length == 0
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text(
                            "Vous n'avez aucune notification",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    :
                 SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return NotificationTile(notification: model.notifications[index],);
                      },
                      childCount: model.notifications?.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}