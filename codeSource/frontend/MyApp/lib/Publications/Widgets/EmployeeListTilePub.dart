import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:flutter/material.dart';
import '../../Screens/Profil.dart';
import 'package:flutter/cupertino.dart';
import 'package:strings/strings.dart';
import '../../WebService/NetworkImageController.dart';
import './PostSettingsWidget.dart';

class EmployeeListTilePub extends StatefulWidget {
  final Employee employee;
  final Publication publication;
  EmployeeListTilePub({@required this.employee, @required this.publication});
  @override
  _EmployeeListTilePubState createState() => _EmployeeListTilePubState();
}

class _EmployeeListTilePubState extends State<EmployeeListTilePub> {

  
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: buildEmployeeImage(widget.employee.imageUrl),
        title: Text(capitalize("${widget.employee?.firstName}")+" "+capitalize("${widget.employee?.lastName}"),style: TextStyle(color: Colors.black,fontFamily: "Times")),
        subtitle: Text("${widget.employee?.agency?.name}",style: TextStyle(fontFamily: "Times"),),
        onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Profil(employeeID: widget.employee?.id)));
                },
      // here i am using the MyPopMenuForPost widget to check the user's rights        
        trailing: PostSettingsWidget(publication: widget.publication, poster: widget.employee,),        
        );
  }

  
  //method to load and construct agency's Logo
  Widget buildEmployeeImage(String imageUrl){
   return FutureBuilder(
      future: NetworkImageController.fetchImage(imageUrl),
      builder: ((BuildContext context, AsyncSnapshot<NetworkImage> image) {
        if (image.hasData) {return _imageForListTile(image.data);} 
        else { return Image(image:AssetImage("asset/img/person.png"));}
      }),
    );
  }


  // i use this the method just to customize the Image
 Widget _imageForListTile(NetworkImage imageUrl){
   // ImageProvider _imageProvider = (imageUrl!=null && imageUrl.trim().isNotEmpty) ? NetworkImage(imageUrl, headers: ) : AssetImage( "asset/img/person.png");
    return Container(
        height: 80.0,
        width: 60.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageUrl,
            ),
            border: Border.all(color: Colors.white, width: 1.0)),
      );
  } 

}