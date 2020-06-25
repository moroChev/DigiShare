import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/roomModel.dart';
import 'package:MyApp/core/viewmodels/messages_model.dart';
import 'package:MyApp/ui/shared/CustomAppBar.dart';
import 'package:MyApp/ui/shared/employee_list_tile.dart';
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
        backgroundColor: Colors.blueGrey[50],
        floatingActionButton: _floatingButton(context),
        appBar: CustomAppBar(key: key, height: 40),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 35.0, top: 20.0, bottom: 10.0),
              child: Text(
                "Messages",
                style: TextStyle(fontSize: 26.0, color: Colors.black54),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: model.state == ViewState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : model.rooms.length == 0
                        ? Center(
                            child: Text(
                              "Votre boite de messages est vide",
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            itemCount: model.rooms.length,
                            itemBuilder: (context, index) {
                              RoomModel room = model.rooms[index];
                              Employee contact = (room.fromUser.id == loggedInUser.id)
                                      ? room.toUser
                                      : room.fromUser;
                              String message = formatMessage(room.lastMessage.message);
                              Widget trailing = constructTrailing(room, loggedInUser);
                              Function onTap = () async {
                                Navigator.pop(context);
                                await Navigator.pushNamed(context, '/Chat', arguments: contact);
                              };
                              return Column(
                                children: [
                                  EmployeeListTile(
                                    employee: contact,
                                    subtitle: message,
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
