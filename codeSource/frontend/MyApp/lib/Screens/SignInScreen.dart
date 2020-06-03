import 'package:MyApp/Screens/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../WebService/AuthController.dart';
import './ToPostScreen.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[

           Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.0), bottomRight: Radius.circular(40.0),),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('asset/img/doIt.jpg')
                  
                )
            ),
          ),

       
            SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.person), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: _loginController,
                          decoration: InputDecoration(hintText: 'Email'),
                        )))
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
                          controller: _passwordController,
                          decoration: InputDecoration(hintText: 'Password'),
                        ))),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 60,
                child: RaisedButton(
                  onPressed: () async{
                   bool connectionSuccessed = await AuthController.attemptLogIn(_loginController.text, _passwordController.text);
                    if(connectionSuccessed)
                    {
                       Navigator.pop(context);
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                    }else{

                    }
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
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, 'SignUp');
            },
                      child: Center(
              child: RichText(
                text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'SIGN UP',
                        style: TextStyle(
                            color: Color(0xFF0DC1D4), fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
            ),
          )
     
        ],
      ),
    );
  }
}


/*    */