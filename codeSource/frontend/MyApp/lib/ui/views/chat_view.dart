import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/viewmodels/chat_model.dart';
import 'file:///C:/Users/Hp/Desktop/My-app/codeSource/frontend/MyApp/lib/ui/widgets/chat_widgets/single_message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/chat_widgets/chat_title_widget.dart';

import 'base_view.dart';

class ChatView extends StatelessWidget {
  final Employee toChatUser;
  ChatView({this.toChatUser}) : super();

  @override
  Widget build(BuildContext context) {
    Employee fromChatUser = Provider.of<Employee>(context);
    return BaseView<ChatModel>(
      onModelReady: (model) => model.init(fromChatUser, toChatUser),
      builder: (context, model, child) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey[200],

        appBar: AppBar(
          elevation: 0.1,
          iconTheme: IconThemeData(color: Colors.black54),
          backgroundColor: Colors.grey[200].withOpacity(0.9),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
                Navigator.pop(context);
                await Navigator.pushNamed(context, '/Messages');
              },
          ),
          title: ChatTitle(
            toChatUser: model.toChatUser,
            userOnlineStatus: model.userOnlineStatus,
          ),
        ),

        body: Container(
          alignment: Alignment.center,
          padding:
              EdgeInsets.only(top: 0.0, bottom: 20.0, left: 15.0, right: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: model.state == ViewState.Busy
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        controller: model.chatListController,
                        itemCount: model.chatMessages.length,
                        itemBuilder: (context, index) {
                          return SingleMessageWidget(
                            isPreviousFromMe: index - 1 > -1
                                ? model.chatMessages[index - 1].from == fromChatUser.id
                                : null,
                            isNextFromMe: index + 1 < model.chatMessages.length
                                ? model.chatMessages[index + 1].from == fromChatUser.id
                                : null,
                            message: model.chatMessages[index],
                            previousSentAt: index - 1 > -1
                                ? model.chatMessages[index - 1].date
                                : null,
                            toChatUserImageUrl: model.toChatUser.imageUrl,
                            resendMessage: model.resendMessage,
                          );
                        },
                      ),
              ),
              _bottomChatArea(fromChatUser, model),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomChatArea(Employee fromChatUser, ChatModel model) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Row(
        children: <Widget>[
          _chatTextArea(model.chatTextController),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.blue,
            ),
            onPressed: () {
              model.sendMessage(fromChatUser.id);
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
