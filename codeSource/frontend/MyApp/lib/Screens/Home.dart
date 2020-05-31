import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signup_ui/WebService/PublicationsController.dart';
import 'package:signup_ui/Widgets/PublicationsList.dart';
import 'package:signup_ui/entities/Publication.dart';
import '../Widgets/CustumAppBar.dart';





class Home extends StatefulWidget {

  @override
  Home_State createState() => Home_State();
}

class Home_State extends State<Home> {

  //our Custum Appbar
  CustumAppBar appBar= new CustumAppBar();
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustumAppBar.getAppBar(context),
      body: FutureBuilder(
                future: PublicationsController.fetchPublications(),
                builder: (context, snapshot){
                  if (snapshot.hasError) print("error in passing data"+snapshot.error);
          
                  return snapshot.hasData
                      ? PublicationsList(publications: snapshot.data)
                      : Center(child: CircularProgressIndicator()); 
                    }
                )

        );
  }
}