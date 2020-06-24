import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/viewmodels/chat_users_model.dart';
import 'package:MyApp/ui/shared/employee_list_tile.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatUsersView extends StatelessWidget {
  _logout(context, ChatUsersModel model) async {
    model.logout();
    await Navigator.pushNamedAndRemoveUntil(context, '/SignIn', ModalRoute.withName('/'));
  }

  _openChatScreen(context, toChatUser) async {
    Navigator.pop(context);
    await Navigator.pushNamed(context, '/Chat', arguments: toChatUser);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatUsersModel>(
      onModelReady: (model) => model.init(Provider.of<Employee>(context)),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black54),
          elevation: 0.0,
          backgroundColor: Colors.grey[200] /*Color(0xFFCFD8DC)*/,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context);
              await Navigator.pushNamed(context, '/Messages');
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _logout(context, model);
              },
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 0.0, bottom: 10.0),
              child: Text(
                "List des contacts",
                style: TextStyle(fontSize: 26.0, color: Colors.black54),
              ),
            ),
            Center(
              child: Text(
                model.connectMessage,
                style: TextStyle(color: Colors.black26),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: model.state == ViewState.Busy
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : model.chatUsers.length == 0
                        ? Text(
                            "L'application n'est pas encore initialisée, aucun contact n'est trouvé ",
                            textAlign: TextAlign.center,
                          )
                        : ListView.builder(
                            itemCount: model.chatUsers.length,
                            itemBuilder: (context, index) {
                              Employee user = model.chatUsers[index];
                              String subtitle = user.agency.name;
                              Widget trailing = Icon(
                                Icons.navigate_next,
                                color: Colors.blue,
                              );
                              Function onTap = () => _openChatScreen(context, user);
                              return Column(
                                children: [
                                  EmployeeListTile(
                                    employee: user,
                                    subtitle: subtitle,
                                    trailing: trailing,
                                    onTap: onTap,
                                  ),
                                  Divider(
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                ],
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
