import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OurAlertDialog {

  final String title;
  final String content;
  final Map<String,String> btnsTextPath;

  OurAlertDialog({this.title, this.content, this.btnsTextPath});

  List<FlatButton> buttons(BuildContext context){
    List<FlatButton> ourButtons = new List<FlatButton>();
    btnsTextPath.forEach(
          (key, value) => ourButtons.add(new FlatButton(
            onPressed: () => Navigator.pushReplacementNamed(context, value),
            child: Text(key)
              )
            )
       );
    return ourButtons;
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title ?? ' '),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(content),
                  ],
                ),
              ),
              actions: buttons(context),
              elevation: 25.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              );
              
        });
  }
}
