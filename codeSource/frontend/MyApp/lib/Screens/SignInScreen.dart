

import 'package:MyApp/InheritedWidgets/UserModel.dart';
import 'package:MyApp/Screens/Home.dart';
import 'package:MyApp/Screens/AgencyScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../WebService/AuthController.dart';
import '../entities/Employee.dart';
import './ToPostScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';



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
      backgroundColor: Color(0xFFF5F5F5),
      
      body: Container(
            decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover, image: AssetImage('asset/img/sliverBackground.jpg'),),
            ),
        child: ListView( 
            children: <Widget>[
              SizedBox(
                height: 220,
              ),
              boxContainer(context),
              SizedBox(
                height: 20,
              ),
            //  signUp(context),
            ],
          ),
        ),
    


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



Container boxContainer(BuildContext context){

  return Container(
              decoration: loginBoxDecoration(),
              width: 330,
              
              child: Column(   
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
                                          controller: _loginController,
                                          decoration: InputDecoration(hintText: 'Login'),
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
      
                     signInButton(context),


                ],
              ),
          );

}

Widget signInButton(BuildContext context){
  return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 50,
                        width: 140,
                        child: RaisedButton(
                          onPressed: () async{
                                AuthController.attemptLogIn(_loginController.text, _passwordController.text)
                                              .then((employee) {
                                                      print("singin the employee is .. $employee");
                                                      if(employee!=null)
                                                      {
                                                        UserModel.of(context).setEmployee(employee);
                                                        Navigator.pop(context);
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                                                      }else{
                                                        print("the employee is null from signIn");
                                                      }
                                                })
                                              .catchError((onError){
                                                        print("error in signin !!!");
                                                });
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
                );

}



Widget signUp(BuildContext context){
  return InkWell(
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
          );

}





}
