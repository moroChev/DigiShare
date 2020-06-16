import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../publications/SinglePublicationWidget.dart';
import '../entities/Publication.dart';

class PublicationsList extends StatefulWidget {

  List<Publication> publications;

  PublicationsList({@required this.publications}){
  }

  @override
  _PublicationsListState createState() => _PublicationsListState();
}

class _PublicationsListState extends State<PublicationsList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.publications != null) ?  
                ListView.builder(
                                 // shrinkWrap: true,
                                  itemCount  : widget.publications.length,
                                  itemBuilder: (context,index){
                                    return SinglePublicationWidget( publication: widget.publications[index],poster: widget.publications[index]?.postedBy);
                                   }
                                )  
            :
                Center(child: CircularProgressIndicator());
  }
}