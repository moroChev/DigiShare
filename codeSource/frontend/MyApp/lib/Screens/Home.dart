import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widgets/CustumAppBar.dart';
import '../WebService/PublicationsController.dart';
import '../Widgets/PublicationsList.dart';
import '../Widgets/SideMenuWidget.dart';
import '../entities/Publication.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';





class Home extends StatefulWidget {

  @override
  Home_State createState() => Home_State();
}

class Home_State extends State<Home> {

  //our Custum Appbar
  CustumAppBar appBar= new CustumAppBar();
  Future<List<Publication>> _publications;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _publications=PublicationsController.fetchPublications();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuWidget(),
      appBar: CustumAppBar.getAppBar(context),
      body: FutureBuilder<List<Publication>>(
                future: _publications,
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