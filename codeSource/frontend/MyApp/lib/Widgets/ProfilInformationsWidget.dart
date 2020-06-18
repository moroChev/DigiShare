import 'package:MyApp/core/models/agency.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class ProfilInformations extends StatelessWidget {
  Employee profil;

  ProfilInformations({Key key, this.profil}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print(
        "wee are in profil informations ... his agency id : ${profil.agency?.id} and one of his pubs is ... ${profil.publicationsObjects.length}");
    return ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        SizedBox(height: 60,),
                        rowForProfilPicture(imageUrl: profil?.imageUrl ),
                        SizedBox(height: 10,),
                        rowFullName(firstName: profil?.firstName,lastName: profil?.lastName),
                        SizedBox(height: 10,),
                        rowPosition(position: profil?.position),
                        SizedBox( height: 10,),
                        rowNbrPosts(nbrPosts: profil?.publicationsObjects?.length),
                        SizedBox(height: 20,),
                        rowGeneralInfos(email: profil?.email,context: context,agency: profil?.agency),
                      //  Divider(),
                      ]     
    );
  }
}


Row rowForProfilPicture({String imageUrl}) {
  ImageProvider _imageProvider = (imageUrl!=null) ? NetworkImage(imageUrl) : AssetImage( "asset/img/person.png");
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 170.0,
        width: 160.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: _imageProvider,
            ),
            border: Border.all(color: Colors.white, width: 6.0)),
      ),
    ],
  );
}

Row rowFullName({String firstName, String lastName}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(capitalize(firstName)+" "+capitalize(lastName),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0,fontFamily: "Times"),),
    ],
  );
}

Row rowPosition({String position}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(capitalize(position),style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0,fontFamily: "Times"),),
    ],
  );
}

Container rowNbrPosts({int nbrPosts}) {
  return Container(
   /*  width: 140.0,
    height: 70.0, */
    height: 70.0,
    margin: EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('$nbrPosts'),
            Text("publications", style: TextStyle(fontFamily: "Times"),),
          ],
        ),
      ],
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xFFFF9F9F9),
      boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5),spreadRadius: 5,blurRadius: 7,offset: Offset(0, 3),),
        ],
      ),
  );
}

Container rowGeneralInfos({String email,Agency agency , BuildContext context}) {
  String nameAgency = agency.name ?? " ";
  String addressAgency = agency.address ?? " "; 
  return Container(
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xFFFF9F9F9),
      boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5),spreadRadius: 5,blurRadius: 7,offset: Offset(0, 3),),
        ],
      ),
    child: Column(
      children: <Widget>[
        //SizedBox(height: 20,),
        ListTile(
          leading: Icon(Icons.mail,color: Colors.blueGrey,),
          title: Text(capitalize(email),style: TextStyle(fontSize: 17.0,fontFamily: "Times"),),
        ),
        Divider(indent: 20, endIndent: 20,),
        ListTile(
          leading: Icon(Icons.business, color: Colors.blueGrey,),
          title: Text(capitalize(nameAgency),style: TextStyle(fontSize: 17.0,fontFamily: "Times"),),
          subtitle: Text('$addressAgency',style: TextStyle(fontSize: 14.0,fontFamily: "Times"),),
          onTap: (){
            Navigator.pushNamed(context, '/Agency', arguments: agency.id);
          },
        ),
      ],
    ),
  );
}




