import 'package:MyApp/core/models/employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';
import '../../../core/enum/user_on_line_status.dart';

class ChatTitle extends StatelessWidget {
  final Employee toChatUser;
  final UserOnlineStatus userOnlineStatus;
  const ChatTitle({
    @required this.toChatUser,
    @required this.userOnlineStatus,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Colors.black45,
      ),
      backgroundColor: Color(0xFFF5F5F8),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () async {
          Navigator.pop(context);
          await Navigator.pushNamed(context, '/Messages');
        },
      ),
      pinned: true,
      floating: false,
      expandedHeight: 100.0,
      bottom: PreferredSize(
        child: Text(
          _getStatusText(),
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black26,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            capitalize(toChatUser.firstName + ' ' + toChatUser.lastName),
            style: TextStyle(fontSize: 16, color: Colors.black45),
          )),
    );
  }

  _getStatusText() {
    if (userOnlineStatus == UserOnlineStatus.online) return 'online';
    if (userOnlineStatus == UserOnlineStatus.not_online) return 'not_online';
    if (userOnlineStatus == UserOnlineStatus.connecting) return 'connecting...';
  }
}
