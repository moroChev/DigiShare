import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:strings/strings.dart';
import 'package:MyApp/ui/views/profil_view.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_image.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_elements/post_settings.dart';


class EmployeeListTilePub extends StatelessWidget {

  final Employee employee;
  final Publication publication;
  
  EmployeeListTilePub({@required this.employee, @required this.publication});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: EmployeeImage(imageUrl: employee.imageUrl),
        title: Text(capitalize("${employee?.firstName}")+" "+capitalize("${employee?.lastName}"),style: TextStyle(color: Colors.black,fontFamily: "Times")),
        subtitle: Text("${employee?.agency?.name}",style: TextStyle(fontFamily: "Times"),),
        onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => ProfilView(idEmployee: employee.id)));
                },
      // here i am using the MyPopMenuForPost widget to check the user's rights        
        trailing: PostSettingsWidget(publication: publication, poster: employee,),        
        );
  }
}