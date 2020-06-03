import 'package:MyApp/Screens/ToPostScreen.dart';
import 'package:strings/strings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import '../Screens/SignInScreen.dart';
import '../Screens/Profil.dart';
import '../Screens/Home.dart';
import '../entities/Employee.dart';
import '../entities/Agency.dart';

class SideMenuWidget extends StatefulWidget {

  @override
  _SideMenuWidgetState createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  String _idEmployee;
  Future<Employee> emp;
  
  Future<Employee> _getEmplyeeFromStorage() async {
   this._idEmployee   = await storage.read(key: 'userId');
   String _firstName  = await storage.read(key: 'firstName');
   String _lastName   = await storage.read(key: 'lastName');
   String _imageUrl   = await storage.read(key: 'imageUrl');
   String _email      = await storage.read(key: 'email');
   String _AgencyName = await storage.read(key: 'AgencyName');
   Agency agency      = Agency(name: _AgencyName);

   Employee emp = Employee(id: this._idEmployee, firstName: _firstName, lastName: _lastName, imageUrl:_imageUrl, email: _email,agency: agency);
   print("get Employee From Strorage $emp");
   return emp;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emp = _getEmplyeeFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
         future: emp,
          builder:(context,snapshot){
           
            if(snapshot.hasError)  print("erreur in sidemenubar") ;
           else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData ) {
             
             return  Drawer(
              child: Column(
                children: <Widget>[
              
                _header(snapshot.data),
                _home(context: context),
                _myProfil(context: context,employee: snapshot.data),
                _notifications(context: context),
                _publier(context:context,employee: snapshot.data ),
                _search(context: context),
                _mySociete(context: context,employee: snapshot.data),
                Expanded(child: Container()),
                Column(
                children: <Widget>[
              
                  _createFooterItem(context: context)
                ],
              ),
                
          ],
        ),
      ) ;
          }else{
            return Center(child: CircularProgressIndicator()); 
          }
          }
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
                  capitalize("${employee?.lastName}")),
              accountEmail: Text("${employee?.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: _imageProvider,
              ),
            ),
          );
}


Widget _home({BuildContext context}){

 return ListTile(
                  selected: true,
                  title: Text(
                    "Acceuil",
                    style: TextStyle(color: Colors.black),
                  ),
                  //   subtitle: Text("yes"),
                  leading: IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.blueGrey,
                    onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
                    },
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
                  },
               
              );

}

Widget _myProfil({BuildContext context,Employee employee}){
return   ListTile(
                  selected: false,
                  title: Text(
                    "Mon Profil",
                    style: TextStyle(color: Colors.black),
                  ),
                  //   subtitle: Text("yes"),
                  leading: IconButton(
                    icon: Icon(Icons.portrait),
                    color: Colors.blueGrey,
                    onPressed: () {
                      Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Profil(employee.id)));
                    },
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Profil(employee.id)));
                  },
               
              ) ;
}

Widget _notifications({BuildContext context,Employee employee}){
return     ListTile(
                  selected: false,
                  title: Text(
                    "Notifications",
                    style: TextStyle(color: Colors.black),
                  ),
                  //   subtitle: Text("yes"),
                  leading: IconButton(
                    icon: Icon(Icons.notifications),
                    color: Colors.blueGrey,
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
                  title: Text(
                    "Chat",
                    style: TextStyle(color: Colors.black),
                  ),
                  //   subtitle: Text("yes"),
                  leading: IconButton(
                    icon: Icon(Icons.chat),
                    color: Colors.blueGrey,
                    onPressed: () {
                      print("notifications");
                    },
                  ),
               
              );
}


Widget _publier({BuildContext context,Employee employee}){

  return       ListTile(
                  selected: false,
                  title: Text(
                    "Publier",
                    style: TextStyle(color: Colors.black),
                  ),
                  //   subtitle: Text("yes"),
                  leading: IconButton(
                    icon: Icon(Icons.public),
                    color: Colors.blueGrey,
                    onPressed: () {
                      Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ToPostScreen()));
                    },
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ToPostScreen()));
                  },
               
              );

}


Widget _search({BuildContext context}){

   return ListTile(
                  selected: false,
                  title: Text(
                    "Chercher",
                    style: TextStyle(color: Colors.black),
                  ),
                  //   subtitle: Text("yes"),
                  leading: IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.blueGrey,
                    onPressed: () {
                      print("notifications");
                    },
                  ),
                );
              

}

Widget _mySociete({BuildContext context,Employee employee})
{
  return       ListTile(
                  selected: false,
                  title: Text(
                    "Ma Societe",
                    style: TextStyle(color: Colors.black),
                  ),
                  //   subtitle: Text("yes"),
                  leading: IconButton(
                    icon: Icon(Icons.group_work),
                    color: Colors.blueGrey,
                    onPressed: () {
                      print("notifications");
                    },
                  ),
                  onTap: (){

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
            child: Text("Se déconnecter"),
          )
        ],
      ),
      onTap: (){
          Navigator.pop(context);
          Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
      },
    );
  }

  }