import 'package:MyApp/Widgets/floatingButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/CustumAppBar.dart';
import '../WebService/PublicationsController.dart';
import '../publications/PublicationsList.dart';
import '../Widgets/SideMenuWidget.dart';
import '../entities/Publication.dart';
import 'dart:async';


class Home extends StatefulWidget {

  Home();
  @override
  Home_State createState() => Home_State();
}

class Home_State extends State<Home> {


  Future<List<Publication>> _publications;


  @override
  void initState() {
    super.initState();
    _publications=PublicationsController.fetchPublications();

  }
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        drawer: SideMenuWidget(),
        appBar: CustomAppBar.getAppBar(context),
        floatingActionButton: FloatingButton(),
        body: FutureBuilder<List<Publication>>(
                  future: _publications,
                  builder: (context, snapshot){
                    if (snapshot.hasError) {
                      print("error in passing data"+snapshot.error);
                     return Center( child:Text("Aucune Publication !") );
                      }      
                    return snapshot.hasData
                        ? PublicationsList(publications: snapshot.data)
                        : Center(child: CircularProgressIndicator()); 
                      }
                  )

    );
  }
}