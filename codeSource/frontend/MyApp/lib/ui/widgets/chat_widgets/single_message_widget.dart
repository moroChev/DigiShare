import 'package:MyApp/core/models/chatMessageModel.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/ui/shared/divider_with_title.dart';
import 'file:///C:/Users/Hp/Desktop/My-app/codeSource/frontend/MyApp/lib/ui/shared/decorated_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constantes/socket_consts.dart' as globals;

class SingleMessageWidget extends StatelessWidget {
  final bool isPreviousFromMe;
  final bool isNextFromMe;
  final ChatMessageModel message;
  final DateTime previousSentAt;
  final String toChatUserImageUrl;
  final Function resendMessage;
  SingleMessageWidget(
      {this.isPreviousFromMe,
      this.message,
      this.isNextFromMe,
      this.previousSentAt,
      this.toChatUserImageUrl,
      this.resendMessage});

  @override
  Widget build(BuildContext context) {
    bool fromMe = message.from == Provider.of<Employee>(context).id;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[

        // Message date divider (if needed)
        (isPreviousFromMe == null || message.date.weekday != previousSentAt.weekday || message.date.difference(previousSentAt).inDays >= 1)
            ? Container(
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
          alignment: Alignment.center,
          child: DividerWithTitle(title: getMessageDateDivider()),
        )
            : Container(),

        Row(
          mainAxisAlignment:
              fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: fromMe ? Alignment.topRight : Alignment.topLeft,
              children: <Widget>[
                // if this msg and the previous one are both from the same person
                // we will not consider padding from top because there will not be an avatar for the user in this case
                (fromMe == isPreviousFromMe)
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(
                            fromMe ? 0 : 20, 0, fromMe ? 20 : 0, 0),
                        child: singleMsg(context, fromMe),
                      )
                    // otherwise we will consider the user's avatar while defining padding for the msg container
                    // if they aren't from the same person and this msg is from me
                    : fromMe
                        ? Container(
                            padding: EdgeInsets.fromLTRB(0, 30, 20, 0),
                            child: singleMsg(context, fromMe),
                          )
                        // if they aren't from the same person and this one isn't from me
                        : Container(
                            padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                            child: singleMsg(context, fromMe),
                          ),
                // defining user's avatar
                // if it's the first msg in this conversation || this msg and the previous one aren't from the same person
                // we will consider tha avatar // otherwise we will add an empty container
                (isPreviousFromMe == null || fromMe != isPreviousFromMe)
                    ? Container(
                        height: 50,
                        width: 50,
                        child: DecoratedLogo(
                          imageUrl: fromMe
                              ? Provider.of<Employee>(context).imageUrl
                              : toChatUserImageUrl,
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
        // SizedBox for separation purposes between successive messages
        SizedBox(height: (fromMe != isNextFromMe) ? 30.0 : 1.0),
      ],
    );
  }

  Widget singleMsg(BuildContext context, bool fromMe) {
    BoxDecoration decoration;
    Color textColor;
    Map map = initDecoration(fromMe);
    decoration = map["decoration"];
    textColor = map["textColor"];
    return Column(
      // My messages will be aligned in my right and the others in my left
      crossAxisAlignment: fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[

        // this container is for the message body
        Container(
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
          constraints: BoxConstraints(
              minWidth: 50, maxWidth: MediaQuery.of(context).size.width - 100),
          decoration: decoration,
          child: Text(
            message.message,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16.0, color: textColor),
          ),
        ),

        // now let's add sent_at date and the message status icon
        (isNextFromMe != null && (fromMe == isNextFromMe))
            ? SizedBox(height: 0.0)
            : Row(
                children: <Widget>[
                  // sent_at date
                  Text(
                    DateFormat('kk:mm').format(message.date),
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 11.0,
                    ),
                  ),
                  SizedBox(width: 3.0),

                  // messageStatus icon only for my messages
                  (!fromMe)
                      ? Container()
                      : (message.status == globals.STATUS_MASSAGE_SENDING)
                          ? IconButton(
                              icon: Icon(Icons.access_time),
                              color: Colors.black38,
                              onPressed: () => resendMessage(message),
                            )
                          : (message.status == globals.STATUS_MASSAGE_NOT_SENT)
                              ? IconButton(
                                  icon: Icon(Icons.not_interested),
                                  color: Colors.red,
                                  onPressed: () => resendMessage(message),
                                )
                              : (message.status == globals.STATUS_MASSAGE_SENT)
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.black38,
                                    )
                                  : (message.status ==
                                          globals.STATUS_MASSAGE_DELIVERED)
                                      ? Icon(
                                          Icons.done_all,
                                          color: Colors.black38,
                                        )
                                      : Icon(
                                          Icons.done_all,
                                          color: Colors.blue,
                                        ),
                ],
              ),
      ],
    );
  }

  String getMessageDateDivider() {
    String date;
    DateTime now = DateTime.now();
    if(isPreviousFromMe == null && now.weekday == message.date.weekday && now.difference(message.date).inHours < 48){
      //if its the first msg in this conversation and we are in the same day as the message.sent_at day
      date = DateFormat('hh:mm aaa').format(message.date);
    }else if (now.weekday != message.date.weekday && now.difference(message.date).inHours < 48) {
      // yesterday
      date = "Hier , " + DateFormat('hh:mm aaa').format(message.date);
    } else if (now.difference(message.date).inDays <= 7) {
      // in this Week
      date = DateFormat('EEE hh:mm aaa').format(message.date);
    } else if (now.year == message.date.year) {
      // in this year
      date = DateFormat('MMMMM.dd hh:mm aaa').format(message.date);
    } else {
      // the year isn't the same
      date = DateFormat('dd.MMMMM.YYYY hh:mm aaa').format(message.date);
    }
    return date;
  }

  Map<String, dynamic> initDecoration(bool fromMe) {
    BoxDecoration decoration;
    Color textColor;
    Map map = new Map<String, dynamic>();
    BoxShadow boxShadow = BoxShadow(
        blurRadius: .5,
        spreadRadius: 1.0,
        color: Colors.black.withOpacity(.12));

    if (fromMe && fromMe == isNextFromMe) {
      decoration = BoxDecoration(
        color: Color.fromRGBO(120, 132, 158, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
        boxShadow: [boxShadow],
      );
    } else if (fromMe) {
      decoration = BoxDecoration(
        color: Color.fromRGBO(120, 132, 158, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
        boxShadow: [boxShadow],
      );
    } else if (!fromMe && fromMe == isNextFromMe) {
      decoration = BoxDecoration(
        color: Color.fromRGBO(50, 115, 255, 0.6),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [boxShadow],
      );
    } else if (!fromMe) {
      decoration = BoxDecoration(
        color: Color.fromRGBO(50, 115, 255, 0.6),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [boxShadow],
      );
    }
    textColor = Colors.white;
    map.putIfAbsent("decoration", () => decoration);
    map.putIfAbsent("textColor", () => textColor);
    return map;
  }
}
