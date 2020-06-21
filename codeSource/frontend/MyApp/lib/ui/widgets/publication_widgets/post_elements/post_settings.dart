import 'package:MyApp/WebService/PublicationsController.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/enum/PostSettingsEnum.dart';

class PostSettingsWidget extends StatefulWidget {

  final Publication publication;
  final Employee poster;
  
  PostSettingsWidget({@required this.publication, @required this.poster});

  @override
  _MyPopMenuForPostState createState() => _MyPopMenuForPostState();
}

class _MyPopMenuForPostState extends State<PostSettingsWidget> {

  Employee user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // receiving the user object from the inhreted widget  //
          user = Provider.of<Employee>(context);
    ////////////////////////////////////////////////////////
    return PopupMenuButton<SETTINGCHOICES>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        icon: Icon(Icons.expand_more),
        onSelected: applySettings,
        itemBuilder: (BuildContext context){
          return listOfChoices();
        }
      );

  }

List<PopupMenuItem<SETTINGCHOICES>> listOfChoices(){

    List<PopupMenuItem<SETTINGCHOICES>> mychoices = [
           PopupMenuItem(value: SETTINGCHOICES.HIDE,child: Text("Masquer"),)
       ];

if(widget.poster.id == user.id){

  mychoices.addAll([
          PopupMenuItem(value: SETTINGCHOICES.MODIFY,child: Text("Modifier",style: TextStyle(fontFamily: "Times"))),
          PopupMenuItem(value: SETTINGCHOICES.REMOVE,child: Text("Supprimer",style: TextStyle(fontFamily: "Times")))
          ]);
  }

if(user.canApprove && user.agency.id == widget.poster.agency.id){
  if(widget.publication.isApproved){
     mychoices.add(PopupMenuItem(value: SETTINGCHOICES.APPROVE,child: Text("Disapprouver",style: TextStyle(fontFamily: "Times"))));
  }else{
     mychoices.add(PopupMenuItem(value: SETTINGCHOICES.APPROVE,child: Text("Approuver",style: TextStyle(fontFamily: "Times"))));
  }
}
    return mychoices;
}  

void applySettings(SETTINGCHOICES choice){

  switch(choice){
    case SETTINGCHOICES.APPROVE  : { print("Approuver est appelé"); approvePublication(widget.publication.id, !widget.publication.isApproved); } break;
    case SETTINGCHOICES.REMOVE   : { print("remove est appelé");    removePublication(widget.publication.id);  } break;
    case SETTINGCHOICES.MODIFY   : { print("modify est appelé");    modifyPublication(); } break;
    case SETTINGCHOICES.HIDE     : {print("hide est appeale");    } break;
  }

}

void removePublication(String idPublication) async {

  PublicationsController.deletePublication(idPublication)
                        .then((result){                                                   
          /*                Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));  */
                        })
                        .catchError((onError)=>print("erreur in deleting the publication .."));

}

void approvePublication(String idPublication, bool isApproved) async {

  PublicationsController.approvePublication(idPublication, isApproved, user.id)
                        .then((result){                                                   
                              setState(() {
                              widget.publication.isApproved = !widget.publication.isApproved;
                            });
                        })
                        .catchError((onError)=>print("erreur in approuving pub"));

}

void modifyPublication() async {
 // PublicationsController.modify
  //Navigator.pop(context);
 // Navigator.push(context, MaterialPageRoute(builder: (context) => ToPostScreen(publication: widget.publication))); 
}

void hidePublication(String idPublication) async {
  /// will be added soon
}

}