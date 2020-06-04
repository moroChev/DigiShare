import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../entities/Publication.dart';
import 'package:strings/strings.dart';
import '../Widgets/SinglePublicationWidget.dart';
import '../WebService/EmployeesController.dart';
import '../entities/Publication.dart';
import '../entities/Employee.dart';

class ProfilInformations extends StatefulWidget {
  Employee profil;

  ProfilInformations({Key key, this.profil}) : super(key: key);

  @override
  _ProfilInformationsState createState() => _ProfilInformationsState();
}

class _ProfilInformationsState extends State<ProfilInformations> {
  @override
  Widget build(BuildContext context) {
    print(
        "wee are in profil informations ... ${widget.profil} and one of his pubs is ... ${widget.profil.publicationsObjects.length}");
    return Container(
      child: this.widget.profil == null
          ? Center(child: CircularProgressIndicator())
          :
           Container(

              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFF7F7F7), Color(0xFFF7F7D7)])),
              child: 
          Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        rowForProfilPicture(imageUrl: widget.profil?.imageUrl ),

                        SizedBox(
                          height: 10,
                        ),
                        rowFullName(
                            firstName: widget.profil?.firstName,
                            lastName: widget.profil?.lastName),
                        SizedBox(
                          height: 10,
                        ),
                        rowPosition(position: widget.profil?.position),

                        SizedBox(
                          height: 10,
                        ),
                        rowNbrPosts(
                            nbrPosts:
                                widget.profil?.publicationsObjects?.length),

                        SizedBox(
                          height: 20,
                        ),
                        rowGeneralInfos(
                            email: widget.profil?.email,
                            agencyName: widget.profil?.agency?.name,
                            agencyAdress: widget.profil?.agency?.address
                            ),
                        Divider(),
                        publicationsList(
                            widget.profil?.publicationsObjects, widget.profil),

                      ]),
                ),
              ],
            ),
    ),
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
      Text(
        capitalize(firstName) + " " + capitalize(lastName),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),
      ),
    ],
  );
}

Row rowPosition({String position}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        capitalize(position),
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
      ),
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
            Text("publications"),
          ],
        ),
      ],
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xFFFF9F9F9),
      boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
  );
}

Container rowGeneralInfos({String email,String agencyName,  String agencyAdress}) {
  String nameAgency = agencyName ?? " ";
  String addressAgency = agencyAdress ?? " "; 
  return Container(
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(0xFFFF9F9F9),
      boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    child: Column(
      children: <Widget>[
        //SizedBox(height: 20,),
        ListTile(
          leading: Icon(
            Icons.mail,
            color: Colors.blueGrey,
          ),
          title: Text(
            capitalize(email),
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
        ),
        ListTile(
          leading: Icon(
            Icons.business,
            color: Colors.blueGrey,
          ),
          title: Text(
            capitalize(nameAgency),
            style: TextStyle(fontSize: 18.0),
          ),
          subtitle: Text('$addressAgency',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
    ),
  );
}

Column publicationsList(List<Publication> posts, Employee emp) {
  return Column(
      children: posts
          ?.map((post) => SinglePublicationWidget(
                publication: post,
                poster: emp,
              ))
          ?.toList());

}

ListView postsList(List<Publication> posts, Employee emp) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: posts.length,
    itemBuilder: (context, index) {
      print("list view builder");
      print(posts[index]);
      return SinglePublicationWidget(publication: posts[index], poster: emp);
    },
  );
}

/* 
  FutureBuilder(
                    future: EmployeesController.fetchProfilPublications(widget.profil.id),
                    builder: (context,snapshot){
                          if (snapshot.hasError) {
                            print(snapshot.error);
                          }
                          return snapshot.hasData
                              ? ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index){
                                  return SinglePublicationWidget(publication: snapshot.data[index],poster: widget.profil);
                              })
                              : Center(child: CircularProgressIndicator());
                        },
                    ), 
    */
