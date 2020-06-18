import 'package:MyApp/core/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/enum/viewstate.dart';
import '../../core/viewmodels/login_model.dart';

import 'base_view.dart';

import '../widgets/login_widgets/login_fields.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signIn(BuildContext context, LoginModel model) async {
    var loginSuccess = await model.login(_loginController.text, _passwordController.text);
    _passwordController.text = '';
    if (loginSuccess) {
      Navigator.pushReplacementNamed(context, '/Home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('asset/img/sliverBackground.jpg'),
            ),
          ),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 220,
              ),
              Container(
                decoration: loginBoxDecoration(),
                height: 300,
                child: Column(
                  children: <Widget>[
                    //text fields for login and password
                    Login(loginController: _loginController, passwordController: _passwordController),
                    Container(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: model.errorMessage == null
                        ? Container()
                        : Text(model.errorMessage, style: TextStyle(color: Colors.red), textAlign: TextAlign.center),
                    ),
                    model.state == ViewState.Busy
                        // on attempt login show circularProgressIndicator
                        ? CircularProgressIndicator()
                        // SignIn button
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: 50,
                                width: 140,
                                child: RaisedButton(
                                  onPressed: () {
                                    signIn(context, model);
                                  },
                                  color: Color(0xFF0DC1D4),
                                  child: Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration loginBoxDecoration() {
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
