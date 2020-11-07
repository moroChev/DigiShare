import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/viewmodels/home_model.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_image.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
import 'package:flutter/material.dart';

class SideMenuWidget extends StatelessWidget {
  final HomeModel model;
  const SideMenuWidget({this.model});

  @override
  Widget build(BuildContext context) {
    print("in SideMenu so ${Provider.of<Employee>(context)?.agency?.id}");
    return Drawer(
        child: rootContainer(Provider.of<Employee>(context), context));
  }

  Widget rootContainer(Employee employee, BuildContext context) {
    return Column(
      children: <Widget>[
        _header(employee),
      //  colorsBar(),
        Expanded(
          child: ListView(
            children: <Widget>[ 
              _listTile(
                  context: context,
                  title: "Acceuil",
                  leadingIcon: Icons.home,
                  onTap: listTileOnTap(context, "/Home", null)),
              _listTile(
                  context: context,
                  title: "Mon Profil",
                  leadingIcon: Icons.portrait,
                  onTap: listTileOnTap(context, "/Profil", employee.id)),
              _listTile(
                  context: context,
                  title: "Notifications",
                  leadingIcon: Icons.notifications,
                  onTap: listTileOnTap(context, "/Notifications", null)),
              _listTile(
                  context: context,
                  title: "Messages",
                  leadingIcon: Icons.chat,
                  onTap: listTileOnTap(context, "/Messages", null)),
              _listTile(
                  context: context,
                  title: "Publier",
                  leadingIcon: Icons.public,
                  onTap: listTileOnTap(context, "/ToPostView", null)),
              _listTile(
                  context: context,
                  title: "Chercher",
                  leadingIcon: Icons.search,
                  onTap: () {}),
              _listTile(
                  context: context,
                  title: "Ma Societe",
                  leadingIcon: Icons.group_work,
                  onTap: listTileOnTap(context, "/Agency", employee.agency.id)),
              _listTile(
                  context: context,
                  title: "DigiShare Map",
                  leadingIcon: Icons.map,
                  onTap: listTileOnTap(context, "/Map", null)),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _createFooterItem(context: context),
        ),
      ],
    );
  }

  Widget _header(Employee employee) {
    return DrawerHeader(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        image: DecorationImage(
          image: new AssetImage("asset/img/backgroundCloud.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: headerContent(employee),
    );
  }

  Widget _listTile(
      {BuildContext context,
      String title,
      IconData leadingIcon,
      Function onTap}) {
    return ListTile(
      selected: false,
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontFamily: "Times"),
      ),
      leading: Icon(leadingIcon, color: Color(0xFF455A64)),
      onTap: onTap,
    );
  }

  Function listTileOnTap(BuildContext context, String namedRoute, String arg) {
    return () {
      Navigator.pop(context);
      Navigator.pushNamed(context, namedRoute, arguments: arg);
    };
  }

  Widget _createFooterItem({BuildContext context}) {
    return Column(
      children: <Widget>[
        Divider(height: 5,color: Colors.black45,indent: 30,endIndent: 30),
        ListTile(
          title:
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.lock_outline),
              Text(
                "Se déconnecter",
                style: TextStyle(color: Colors.black, fontFamily: "Times"),
              ),
            ],
          ),
          onTap: () {
            model.logout();
            Navigator.pushNamedAndRemoveUntil(
                context, '/SignIn', ModalRoute.withName('/'));
          },
        ),
      ],
    );
  }

  Widget headerContent(Employee employee){
    return Container(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[    
            Padding(padding: EdgeInsets.only(left: 10),
            child: employee.imageUrl != null ?  EmployeeImage(imageUrl: employee.imageUrl)
            : AssetImage("asset/img/person.png") ,
            )
          ],),
          Row(
            children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 70),
              child: Text(
                    capitalize(employee.firstName) + ' ' + capitalize(employee.lastName),
                    style: TextStyle(
                        color: Colors.white70,
                        fontFamily: "Times",
                        fontSize: 20,),
                  ),
            ),
          ],),
          Row(
            children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 70),
              child: Text(
                      "${employee?.email}",
                      style: TextStyle(color: Colors.white60,fontSize: 10),
                    ),
            ),
          ],)
        ],
      )
    );
  }

 
}
