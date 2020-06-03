import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SinglePublicationWidget.dart';
import '../entities/Publication.dart';

class PublicationsList extends StatefulWidget {

  List<Publication> publications;

  PublicationsList({this.publications}){
  }

  @override
  _PublicationsListState createState() => _PublicationsListState();
}

class _PublicationsListState extends State<PublicationsList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return (widget.publications != null) ?  ListView.builder(
                                                          itemCount: widget.publications.length,
                                                          itemBuilder: (context,index){
                                                            return SinglePublicationWidget( publication: widget.publications[index],poster: widget.publications[index].postedBy);
                                                          }
                                                         )  
                                                            :
                                            Center(child: CircularProgressIndicator());
  }
}