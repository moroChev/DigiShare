import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/viewmodels/chat_users_model.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_list_tile.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatUsersView extends StatelessWidget {
  _logout(context, ChatUsersModel model) async {
    model.logout();
    await Navigator.pushNamedAndRemoveUntil(
        context, '/SignIn', ModalRoute.withName('/'));
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
        backgroundColor: Color(0xFFF5F5F8),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
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
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    _logout(context, model);
                  },
                )
              ],
              pinned: true,
              floating: false,
              expandedHeight: 100.0,
              bottom: PreferredSize(
                child: Center(
                  child: Text(
                    model.connectMessage,
                    style: TextStyle(color: Colors.black26),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('List des contacts',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Times",
                          color: Colors.black))),
            ),
            model.state == ViewState.Busy
                ? SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : model.chatUsers.length == 0
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text(
                            "L'application n'est pas encore initialisée, aucun contact n'est trouvé ",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            Employee user = model.chatUsers[index];
                            String subtitle = user.agency.name;
                            Widget trailing = Icon(
                              Icons.navigate_next,
                              color: Colors.blue,
                            );
                            Function onTap =
                                () => _openChatScreen(context, user);
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
                          childCount: model.chatUsers?.length,
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
