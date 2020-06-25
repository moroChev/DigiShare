import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/ui/widgets/to_post_widgets/to_post_box/tp_show_image.dart';
import 'package:MyApp/ui/widgets/to_post_widgets/to_post_box/tp_textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_list_tile.dart';


class PublicationBox extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
        Employee user = Provider.of(context);
        print("postBox #####################  ${user?.agency}");
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: _boxDecoration(),
            height: 420,
            width: 340,
            child: Wrap(
              children: <Widget>[
                EmployeeListTile(employee: user, agency: user?.agency),
                PostTextField(),
                ShowImage(),
              ],
            ),
          ),
        );
     }
  

  BoxDecoration _boxDecoration(){
    return BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow:[ BoxShadow(color: Colors.grey.withOpacity(0.5),spreadRadius: 5,blurRadius: 7,offset: Offset(0, 3),) ],
          );
  }

}