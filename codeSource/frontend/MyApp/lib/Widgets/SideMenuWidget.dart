import 'package:MyApp/core/models/employee.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
import 'package:flutter/material.dart';
class SideMenuWidget extends StatefulWidget {

  @override
  _SideMenuWidgetState createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("in SideMenu so ${Provider.of<Employee>(context)?.agency?.id}");
    return  Drawer(
              child:rootContainer(Provider.of<Employee>(context), context)
        );
  }


Widget rootContainer(Employee employee, BuildContext context){

return Column(
  children: <Widget>[
                _header(employee),
                _home(context: context),
                _myProfil(context: context,employee: employee),
                _notifications(context: context),
                _publier(context:context,employee: employee ),
                _search(context: context),
                _mySociete(context: context,employee: employee),
                _map(context: context),

                Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _createFooterItem(context: context),
                  ),
                ),
            
],
);

}




Widget _header(Employee employee)
{
  ImageProvider _imageProvider = (employee?.imageUrl!=null) ? NetworkImage(employee?.imageUrl) : AssetImage( "asset/img/person.png");
  return   DrawerHeader(
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
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage("asset/img/backgroundCloud.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              accountName: Text(capitalize("${employee?.firstName}") +
                  " " +
                  capitalize("${employee?.lastName}") ,style: TextStyle(color: Colors.black, fontFamily: "Times", fontWeight: FontWeight.w200,fontStyle: FontStyle.italic ),),
              accountEmail: Text("${employee?.email}" ,style: TextStyle(color: Color(0xFFFFCDD2), fontFamily: "Times"),),
              currentAccountPicture: CircleAvatar(
                backgroundImage: _imageProvider,
              ),
            ),
          );
}


Widget _home({BuildContext context}){

 return ListTile(
          selected: true,
          title: Text("Acceuil",style: TextStyle(color: Colors.black,fontFamily: "Times")),
          leading: IconButton(
            icon: Icon(Icons.home),
            color: Color(0xFF455A64),
            onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(
            context, '/Home');
            },
          ),
          onTap: (){
            Navigator.pop(context);
            Navigator.pushNamed(
            context,'/Home');
          },  
      );

}

Widget _myProfil({BuildContext context,Employee employee}){
return   ListTile(
          selected: false,
          title: Text( "Mon Profil",style: TextStyle(color: Colors.black,fontFamily: "Times"),),
          leading: IconButton(
            icon: Icon(Icons.portrait),
            color: Color(0xFF455A64),
            onPressed: () {
              Navigator.pop(context);
            Navigator.pushNamed(
            context, '/Profile' , arguments: employee.id);
            },
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
                context, '/Profile' , arguments: employee.id);
          },
               
              ) ;
}

Widget _notifications({BuildContext context,Employee employee}){
return  ListTile(
          selected: false,
          title: Text("Notifications",style: TextStyle(color: Colors.black,fontFamily: "Times")),
          leading: IconButton(
            icon: Icon(Icons.notifications),
            color: Color(0xFF455A64),
            onPressed: () {
              print("notifications");
            },
          ),
        
        );
}

Widget _chat({BuildContext context,Employee employee})
{
return      ListTile(
              selected: false,
              title: Text("Chat",style: TextStyle(color: Colors.black ,fontFamily: "Times"),),  
              leading: IconButton(
                icon: Icon(Icons.chat),
                color: Color(0xFF455A64),
                onPressed: () {
                  print("notifications");
                },
              ),
               
              );
}


Widget _publier({BuildContext context,Employee employee}){

  return ListTile(
          selected: false,
          title: Text("Publier",style: TextStyle(color: Colors.black,fontFamily: "Times"),),
          leading: IconButton(
                    icon: Icon(Icons.public),
                    color: Color(0xFF455A64),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/ToPostScreen');
                    },
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/ToPostScreen');
                  },
               
              );

}


Widget _search({BuildContext context}){

   return ListTile(
                  selected: false,
                  title: Text("Chercher",style: TextStyle(color: Colors.black,fontFamily: "Times")),
                  leading: IconButton(
                    icon: Icon(Icons.search),
                    color: Color(0xFF455A64),
                    onPressed: () { },
                  ),
                );
              

}

Widget _mySociete({BuildContext context,Employee employee})
{
  return  ListTile(
            selected: false,
            title: Text("Ma Societe",style: TextStyle(color: Colors.black,fontFamily: "Times"),),
            leading: IconButton(
                    icon: Icon(Icons.group_work),
                    color: Color(0xFF455A64),
                    onPressed: (){
                      print("go to agency ${employee.agency.id}");
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, '/Agency', arguments: employee.agency.id);
                    },
                  ),
                  onTap: (){
                             print("go to agency ${employee.agency.id}");
                    Navigator.pop(context);
                    Navigator.pushNamed(
                    context, '/Agency', arguments: employee.agency.id);
                  },
              
              );

}


  Widget _map({BuildContext context}){

    return ListTile(
      selected: true,
      title: Text("Cart",style: TextStyle(color: Colors.black,fontFamily: "Times")),
      leading: IconButton(
        icon: Icon(Icons.map),
        color: Color(0xFF455A64),
      ),
      onTap: (){
        Navigator.pop(context);
        Navigator.pushNamed(context,'/Map');
      },
    );

  }




Widget _createFooterItem({BuildContext context}){
    return ListTile(
      title: Row(
        children: <Widget>[
          SizedBox(width: 10,),
          Icon(Icons.lock_outline),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text("Se déconnecter" ,style: TextStyle(color: Colors.black ,fontFamily: "Times"),),
          )
        ],
      ),
      onTap: (){
          Navigator.pop(context);
          Navigator.pushNamed(
          context, '/SignIn');
      },
    );
  }

  }