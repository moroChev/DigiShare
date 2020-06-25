import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/roomModel.dart';
import 'package:MyApp/core/viewmodels/messages_model.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_list_tile.dart';
import 'package:MyApp/ui/shared/searchBar.dart';
import 'package:provider/provider.dart';
import '../../core/constantes/socket_consts.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Employee loggedInUser = Provider.of<Employee>(context);
    return BaseView<MessagesModel>(
      onModelReady: (model) => model.init(loggedInUser.id),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0xFFF5F5F8),
        floatingActionButton: _floatingButton(context),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(
                color: Colors.black45,
              ),
              backgroundColor: Color(0xFFF5F5F8),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SearchBar(),
                ],
              ),
              pinned: true,
              floating: false,
              expandedHeight: 100.0,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text('Messages',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Times",
                          color: Colors.black))),
            ),
            model.state == ViewState.Busy
                ? SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : model.rooms.length == 0
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text(
                            "Votre boite de messages est vide",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            RoomModel room = model.rooms[index];
                            Employee contact =
                                (room.fromUser.id == loggedInUser.id)
                                    ? room.toUser
                                    : room.fromUser;
                            String message =
                                formatMessage(room.lastMessage.message);
                            Widget trailing =
                                constructTrailing(room, loggedInUser);
                            Function onTap = () async {
                              Navigator.pop(context);
                              await Navigator.pushNamed(context, '/Chat',
                                  arguments: contact);
                            };
                            return Column(
                              children: [
                                EmployeeListTile(
                                  employee: contact,
                                  subtitle: message,
                                  trailing: trailing,
                                  onTap: onTap,
                                ),
                                Divider(indent: 10, endIndent: 10),
                              ],
                            );
                          },
                          childCount: model.rooms.length,
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  formatMessage(String message) {
    if (message == null) return "";
    int maxLength = 30;
    List<String> tokens = message.split(' ').toList();
    String finalMessage = "";
    int size = 0;
    for (String token in tokens) {
      if (size + token.length > maxLength)
        return finalMessage + " ...";
      else {
        size += token.length;
        finalMessage += " " + token;
      }
    }
    return finalMessage;
  }

  constructTrailing(RoomModel room, Employee loggedInUser) {
    return (room.lastMessage.from != loggedInUser.id &&
            room.lastMessage.status != globals.STATUS_MASSAGE_SEEN)
        ? Icon(Icons.fiber_manual_record, color: Colors.red)
        : Text(" ");
  }

  Widget _floatingButton(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Color(0xFF0DC1DD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          Icons.add,
          color: Colors.blueGrey[100],
        ),
        onPressed: () async {
          Navigator.pop(context);
          await Navigator.pushNamed(context, '/ChatUsers');
        });
  }
}
