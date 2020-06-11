import 'package:MyApp/entities/Employee.dart';
import 'package:flutter/material.dart';
import '../Screens/Profil.dart';
import 'package:flutter/cupertino.dart';
import 'package:strings/strings.dart';
import '../WebService/NetworkImageController.dart';

class EmployeeListTile extends StatefulWidget {
  final Employee employee;
  EmployeeListTile({@required this.employee});
  @override
  _EmployeeListTileState createState() => _EmployeeListTileState();
}

class _EmployeeListTileState extends State<EmployeeListTile> {

  // just reminder
  // things to take in consideration :
  // 1) about the button in the right (more icon)
  //    a) modify option must appear only for the post owner (userId = publication.postedBy.id)
  //    b) delete option must appear only for the post owner                  ..
  //    c) approuve option must appear only for the user who have canApprouve=true field of the employee class
  //    d) dispear option can be offered to evrybody
  //    .
  //    .
  //    .
  //    i think i am going to need two employee listTiles one for posts only and one generic to display generic infos which are fullname and agency name
  




  
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: buildEmployeeImage(widget.employee.imageUrl),
        title: Text(capitalize("${widget.employee?.firstName}")+" "+capitalize("${widget.employee?.lastName}"),style: TextStyle(color: Colors.black,fontFamily: "Times")),
        subtitle: Text("${widget.employee?.agency?.name}",style: TextStyle(fontFamily: "Times"),),
        onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Profil(employeeID: widget.employee?.id)));
                },
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