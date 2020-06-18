import 'package:MyApp/entities/Employee.dart';
import 'package:flutter/material.dart';
import '../Screens/Profil.dart';
import 'package:flutter/cupertino.dart';
import 'package:strings/strings.dart';
import '../WebService/NetworkImageController.dart';

class EmployeeListTileA extends StatefulWidget {
  final Employee employee;
  final String agencyName;
  EmployeeListTileA({@required this.employee, @required this.agencyName});
  @override
  _EmployeeListTileState createState() => _EmployeeListTileState();
}

class _EmployeeListTileState extends State<EmployeeListTileA> {



  
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: buildEmployeeImage(widget.employee.imageUrl),
        title: Text(capitalize("${widget.employee?.firstName}")+" "+capitalize("${widget.employee?.lastName}"),style: TextStyle(color: Colors.black,fontFamily: "Times")),
        subtitle: Text("${widget.agencyName}",style: TextStyle(fontFamily: "Times"),),
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