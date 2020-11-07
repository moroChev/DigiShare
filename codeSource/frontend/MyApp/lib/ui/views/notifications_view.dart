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
      onModelReady: (model) => model.getAllnotifications(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingButton(),
        backgroundColor: Color(0xFFF5F5F8),
        body: CustomScrollView(
          slivers: model.state == ViewState.Busy
                ? [
                  OurSliverAppBar(title: "Notifications"),
                  SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator())
                    )]
                   : model.notifications.length == 0
                    ? [
                      OurSliverAppBar(title: "Notifications"),
                      SliverFillRemaining(
                        child: Center(child: Text("Vous n'avez aucune notification", textAlign: TextAlign.center))
                        )
                      ]
                    : 
                    [
                      OurSliverAppBar(title: "Notifications"),
                        SliverToBoxAdapter(
                          child: Container(
                            color: Color(0xFFF5F5F8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  child: Text("Vider la boite",style: TextStyle(color: Color(0xFF4267b2),fontFamily: "Times")),
                                  onPressed: () => model.deleteAllNotifications(),
                                )
                              ],
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              print('__________________________________________________________________________________________');
                              print('SliverChildBuilder index : $index : ${model.notifications[index]?.publication?.content}');
                              return NotificationTile(notification: model.notifications[index]);
                            },
                            childCount: model.notifications?.length,
                          ),
                        ),
                      ]
        ),
      ),
    );
  }
}
