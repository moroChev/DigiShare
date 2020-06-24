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
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            capitalize(toChatUser.firstName + ' ' + toChatUser.lastName),
            style: TextStyle(color: Colors.black45),
          ),
          Text(
            _getStatusText(),
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }

  _getStatusText() {
    if (userOnlineStatus == UserOnlineStatus.online) return 'online';
    if (userOnlineStatus == UserOnlineStatus.not_online) return 'not_online';
    if (userOnlineStatus == UserOnlineStatus.connecting) return 'connecting...';
  }
}
