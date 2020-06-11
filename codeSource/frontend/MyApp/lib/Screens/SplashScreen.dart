import 'package:MyApp/WebService/AuthController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  Future _checkSignIn(BuildContext context) async {
    bool isAuthenticated = await AuthController.checkAuth();
    await Future.delayed(Duration(seconds: 5), () => print('Hello to My App'));
    if (isAuthenticated) {

      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, '/Home', (Route<dynamic> route) => false);
      
    } else {

      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, '/SignIn', (Route<dynamic> route) => false);

    }
  }

  @override
  Widget build(BuildContext context) {
    _checkSignIn(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomRight,end: Alignment.topLeft,colors: [Colors.indigo, Color(0xFF0DC1D4)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Image(image: AssetImage('asset/img/logo_JP&CO.png'),width: 120,height: 80,),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text('Inter agencies social network', style: TextStyle(fontSize: 13, color: Colors.white70),),
            ),
            CircularProgressIndicator(backgroundColor: Colors.white70,),
          ],
        ),
      ),
    );
  }
}