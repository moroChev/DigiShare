import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomChatArea extends StatelessWidget {
  final String fromChatUSerId;
  final TextEditingController chatTextController;
  final Function sendMessage;
  const BottomChatArea(
      {this.fromChatUSerId, this.chatTextController, this.sendMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Row(
        children: <Widget>[
          _chatTextArea(chatTextController),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.blue,
            ),
            onPressed: () {
              sendMessage(fromChatUSerId);
            },
          )
        ],
      ),
    );
  }

  Widget _chatTextArea(TextEditingController controller) {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(10.0),
          hintText: 'Type message',
        ),
      ),
    );
  }
}
