import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/viewmodels/chat_model.dart';
import 'package:MyApp/ui/widgets/chat_widgets/buttom_chat_area_widget.dart';
import 'package:MyApp/ui/widgets/chat_widgets/single_message_widget.dart';
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
        body: CustomScrollView(
          controller: model.chatListController,
          slivers: <Widget>[
            ChatTitle(
              userOnlineStatus: model.userOnlineStatus,
              toChatUser: toChatUser,
            ),
            model.state == ViewState.Busy
                ? SliverFillRemaining(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return SingleMessageWidget(
                          isPreviousFromMe: index - 1 > -1
                              ? model.chatMessages[index - 1].from ==
                                  fromChatUser.id
                              : null,
                          isNextFromMe: index + 1 < model.chatMessages.length
                              ? model.chatMessages[index + 1].from ==
                                  fromChatUser.id
                              : null,
                          message: model.chatMessages[index],
                          previousSentAt: index - 1 > -1
                              ? model.chatMessages[index - 1].date
                              : null,
                          toChatUserImageUrl: model.toChatUser.imageUrl,
                          resendMessage: model.resendMessage,
                        );
                      },
                      childCount: model.chatMessages.length,
                    ),
                  ),
            SliverFillRemaining(
              fillOverscroll: false,
              hasScrollBody: false,
              child: SizedBox(
                height: 100,
              ),
            )
          ],
        ),
        bottomSheet: Container(
          margin: EdgeInsets.fromLTRB(5, 0, 0, 10),
          child: BottomChatArea(
            fromChatUSerId: fromChatUser.id,
            chatTextController: model.chatTextController,
            sendMessage: model.sendMessage,
          ),
        ),
      ),
    );
  }
}
