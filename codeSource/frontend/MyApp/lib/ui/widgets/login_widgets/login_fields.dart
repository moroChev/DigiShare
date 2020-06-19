import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final String validationMessage;

  Login({@required this.loginController, @required this.passwordController, this.validationMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.person), onPressed: null),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(right: 20, left: 10),
                      child: TextField(
                        controller: loginController,
                        decoration: InputDecoration(hintText: 'Login'),
                      ),
                  ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.lock), onPressed: null),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(right: 20, left: 10),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(hintText: 'Password'),
                      ),
                  ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BoxDecoration loginBoxDecoration(){
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFFFF9F9F9),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }
}
