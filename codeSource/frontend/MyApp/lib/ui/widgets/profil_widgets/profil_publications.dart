import 'package:MyApp/core/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/ui/widgets/publication_widgets/single_post.dart';



class ProfilPublications extends StatelessWidget {

 final List<Publication> publications;
 final Employee employee;

 ProfilPublications({@required this.publications, @required this.employee});


  @override
  Widget build(BuildContext context) {
  return publications?.length ==0 ?
   Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[ 
     Text("M. ${employee.lastName} n'\ a aucune publication",style: TextStyle(color: Colors.blueGrey,fontFamily:"Times"),)
     ])
   :
   Column(children: publications?.map((post) => SinglePublicationWidget(publication: post,poster: employee,))?.toList());

  }
}