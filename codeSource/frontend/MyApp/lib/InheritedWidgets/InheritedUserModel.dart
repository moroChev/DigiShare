import 'package:MyApp/InheritedWidgets/UserModel.dart';
import 'package:flutter/cupertino.dart';

class InheritedUserModel extends InheritedWidget{

 @override
 final Key key;
 final Widget child;
 final UserModelState currentUserState;

  InheritedUserModel({this.key,this.currentUserState,this.child});


  @override
  bool updateShouldNotify(InheritedUserModel oldWidget) {
    return true; 
  }

}