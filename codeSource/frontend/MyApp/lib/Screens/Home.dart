import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/CustumAppBar.dart';
import '../WebService/PublicationsController.dart';
import '../Widgets/PublicationsList.dart';





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