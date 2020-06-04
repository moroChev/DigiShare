import 'package:MyApp/WebService/PublicationsController.dart';
import 'package:MyApp/entities/Agency.dart';
import 'package:MyApp/entities/Employee.dart';
import 'package:MyApp/entities/Publication.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './Home.dart';
import '../Widgets/SideMenuWidget.dart';
import 'dart:io';
import '../Widgets/CustumAppBar.dart';
import '../Widgets/floatingButton.dart';

class ToPostScreen extends StatefulWidget {
  @override
  _ToPostScreenState createState() => _ToPostScreenState();
}

class _ToPostScreenState extends State<ToPostScreen> {
  TextEditingController _contentController = TextEditingController();
  File _image = null;
  final _picker = ImagePicker();
  String _idEmployee;
  Future<Employee> _employee;
  static FlutterSecureStorage storage = FlutterSecureStorage();
  bool _hasError = false;

  Future _getImage(ImageSource source) async {
    final pickedImage = await _picker.getImage(source: source);
    setState(() {
      _image = File(pickedImage.path);
      print("-------------------------------------- image picked yes ! ");
    });
  }

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
    setState(() {
      print("before get Employee Id : Method from initState $_idEmployee");
      _employee =_getEmplyeeFromStorage();
      print("After get Employee Id from initState $_idEmployee");
    });

  }

  Publication _constructPublicationObjectToPost(String content){
   
     Employee emp = Employee(id:this._idEmployee);
      print("Contsruct Pubublication  object Employee Id $emp");
     return Publication(content: content, postedBy: emp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuWidget(),
      appBar: CustumAppBar.getAppBar(context),
      floatingActionButton: FloatingButton(),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 70.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _erreurMessage(_hasError),
              _createPostButton(),
              
            ],
          ),
          _postBox(image: _image, context: context, employee: _employee),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _selectImage(),
              _cancelButton(),
            ],
          ),
        ],
      )),
    );
  }

  // the container of the post box so it contains profile tile, textfield and the image if one is selected
  Widget _postBox(
      {File image, BuildContext context, Future<Employee> employee}) {
        print(" post box the future vient d'aariver...");
    return FutureBuilder<Employee>(
        future: employee,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("error find the employee to post ...");
            return Container(width: 0, height: 0);
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            print("has data and snapshot is ");
            Employee poster = snapshot.data;

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Wrap(
                children: <Widget>[
                  _profilTile(poster: poster),
                  _textBox(),
                  _showImage(image),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
// button to select an image 
  Widget _selectImage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: RaisedButton(
        onPressed: () {
          _getImage(ImageSource.gallery);
        },
        child: Text("Selectionner image"),
      ),
    );
  }
// button to post the publication it uses postPublication method from PublicationsController 
  Widget _createPostButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: RaisedButton(
        onPressed: ()async {
          print("publier !");
          Publication publication = _constructPublicationObjectToPost(_contentController.text);
          bool createdWithSuccess = await PublicationsController.postPublication(publication, _image);

           if(createdWithSuccess)
                    {
                       Navigator.pop(context);
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                    }
          else{
                 setState(() {
                  _hasError=true;
                     });
            }
        },
        child: Text("publier"),
      ),
    );
  }
 Widget _erreurMessage(bool hasError) {
    return hasError==true ? Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Text("erreur in send message"),
    ) : Text(" ");
  }


// the button to cancel the whole operation
  Widget _cancelButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: RaisedButton(
        onPressed: () {
          print("annuler image !");
          setState(() {
            _image = null;
          });
        },
        child: Text("annuler"),
      ),
    );
  }
// container to display the selected image
  Widget _showImage(File image) {
    return image != null
        ? Container(
            padding: EdgeInsets.all(5),
            child: Image.file(
              image,
              width: 340,
              height: 300,
            ))
        : Text(" ");
  }
// textfield to write the post in
  Widget _textBox() {
    return Container(
      width: 340,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: TextField(
        controller: _contentController,
        maxLines: 2,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
// the header showing to profil informations
  Widget _profilTile({Employee poster}) {
    print(" .... profile tile $poster");
    return Container(
      width: 340,
      child: ListTile(
        leading: FadeInImage(
          image: (poster?.imageUrl != null)
              ? NetworkImage("${poster?.imageUrl}")
              : AssetImage('asset/img/person.png'),
          placeholder: AssetImage('asset/img/person.png'),
        ),
        title: RichText(
          text: TextSpan(
            text: capitalize("${poster?.firstName}") +
                " " +
                capitalize("${poster?.lastName}"),
            style: TextStyle(color: Colors.black),
          ),
        ),
        subtitle: Text("${poster?.agency?.name}"),
      ),
    );
  }
}
