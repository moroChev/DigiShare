import 'package:MyApp/WebService/PublicationsController.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/ui/shared/employee_list_tile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Home.dart';
import '../Widgets/SideMenuWidget.dart';
import 'dart:io';
import '../Widgets/CustumAppBar.dart';
import '../Publications/Widgets/PostSettingsEnum.dart';

class ToPostScreen extends StatefulWidget {
  Publication publication;
  ToPostScreen({this.publication});
  @override
  _ToPostScreenState createState() => _ToPostScreenState();
}

class _ToPostScreenState extends State<ToPostScreen> {

  ///this widget is containing a bunch of methods and it may be easy to be wasted amoung them
  ///that's why i find it mandatory to explain
  /// explanation of the code :
  /// the screen contains 5 gobal rows 
  /// the first one contains the select image button and error message if there is an error
  /// the second one is the list Tile that display user informations
  /// the third one is textField input
  /// the fourth one is the image if there is one
  /// the fifth one is the row containing cancel button and post button
  /// Okay ... now let's explain the methods

  /// Row 1 : the container method is rowOne() line 67
  /// error message on the right the method is : _erreurMessage(bool _hasError)
  /// select image on the left the method is :  _selectImageButton()
  

  /// Row 2 : ListTile and it's the EmployeeListTile widget from  global Widgets folder 
  /// Row 3 : TextInput method is _textBox() 
  /// Row 4 : Image of the post if one is selected _showImage(File image)
  /// those three rows are containerized in _postBox(File image) Line 103


  /// Row 5 : the continer method is _rowFive() Line 89
  /// cancel Button is hundled by the _cancelButton() method
  /// post button is hundled by the _createPostButton() method
   

  TextEditingController _contentController = TextEditingController();
  Image _imageTodDisplay;
  File _image;
  final _picker = ImagePicker();
  bool _hasError = false;
  bool isNewPost;

  /// this method uses Picker package to get the image from the phone gallery
  /// it's called in Select image button
  Future _getImage(ImageSource source) async {
    final pickedImage = await _picker.getImage(source: source);
    setState(() {
       _image = File(pickedImage.path);
      _imageTodDisplay =  Image.file( _image, height: 220, width: 350);   
      print("-------------------------------------- image picked yes ! -------------------");
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isNewPost = ( widget.publication?.imageUrl == null && widget.publication?.content == null );
      _imageTodDisplay= widget.publication?.imageUrl == null ? null : Image.network(widget.publication?.imageUrl, height: 220, width: 350);
      _contentController.text = widget.publication?.content;
    });
  }

  Publication _constructPublicationObjectToPost({String content,@required Employee employee}){
      print("Contsruct Pubublication  object Employee Id $employee");
      Publication pub;
      if(widget.publication!=null){  
          widget.publication.content = content;
          widget.publication.postedBy = employee;
          pub = widget.publication;
      }else{
        pub = Publication(content: content, postedBy: employee);
      }
     return pub;
  }

Widget _rowOne(){
  return Row(
            mainAxisAlignment: MainAxisAlignment.end,   
            children: <Widget>[
              _erreurMessage(_hasError),
              _selectImageButton(),
            ],
      );
}  

Widget _rowFive(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[           
             _cancelButton(),
             _createPostButton(),
      ],
  );
}

/// the container of the post box so it contains profile tile, textfield and the image if one is selected
  Widget _postBox() {
        print(" post box the future vient d'aariver...");
    return 
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          height: 420,
          width: 340,
          child: Wrap(
            children: <Widget>[
              EmployeeListTile(employee: Provider.of<Employee>(context)),
              _textBox(),
              _showImage(),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow:[ BoxShadow(color: Colors.grey.withOpacity(0.5),spreadRadius: 5,blurRadius: 7,offset: Offset(0, 3),) ],
          ),
    );
  } 
 
/// button to select an image 
  Widget _selectImageButton() {
    return Container(
            height: 50,
            width: 160,
            child: RaisedButton(
              color: Color(0xFF454F63),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              onPressed: () { _getImage(ImageSource.gallery);},
              child: Text("Selectionner image"),
            ),
         );
  }
// button to post the publication it uses postPublication method from PublicationsController 
  Widget _createPostButton() {
    return ButtonTheme(
          height: 50,
          minWidth: 140,
          child: RaisedButton(
            color: Color(0xFF0DC1DD),
            textColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
            onPressed: ()async {
              print("publier !");
              Publication publication = _constructPublicationObjectToPost(
                                                         content:_contentController.text,
                                                         employee: Provider.of<Employee>(context)
                                                         );
              bool createdWithSuccess = await PublicationsController.postPublication(
                                                         publication: publication,
                                                         imageUrl: _image,
                                                         requestType: isNewPost ? RequestChoices.CREATE : RequestChoices.MODIFY
                                                         );
              if(createdWithSuccess)
                  {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                  }
              else{
                      setState(() { _hasError=true; });
                  }
              },
              child: Text("Publier"),
            ),
    );
  }

 Widget _erreurMessage(bool hasError) {
    return hasError==true ? 
    Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Text("Erreur in sending message", style: TextStyle(color: Colors.black ,fontFamily: "Times"),),
    ) 
    :
    Text(" ");
  }


// the button to cancel the whole operation
  Widget _cancelButton() {
    return ButtonTheme(
            height: 50,
            minWidth: 140,
            child: RaisedButton(
              color: Color(0xFFE2E4EB),
              textColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                if(_image!=null){
                  setState(() { 
                    _image = null;
                    _imageTodDisplay = null;
                     });
                }else{
                  Navigator.pop(context);
                  Navigator.push( context, MaterialPageRoute( builder: (context) => Home()));
                }
              },
              child: Text("Annuler"),
      ),
    );
  }
// container to display the selected image
  Widget _showImage() {
    return ( _imageTodDisplay != null)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[     
              SizedBox(
                height: 240,
                width: 320,
                child: Container(
                  padding: EdgeInsets.only(bottom: 10, top: 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.white, width: 1.0)),
                  child: _imageTodDisplay,
                    ),
                ),
          ],
        )
        : Text(" ");
  }


// textfield where can the user write the post 
  Widget _textBox() {
    return Container(
      width: 340,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: TextField(
        controller: _contentController,
        maxLines: 4,
        decoration: InputDecoration(hintText: "text ...",border: InputBorder.none),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuWidget(),
      appBar: CustomAppBar.getAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 60.0,),
            _rowOne(),
            SizedBox(height: 25.0,),
            _postBox(),
            SizedBox(height: 40.0,),
            _rowFive(),
            SizedBox(height: 40.0,), 
        ],
      )),
    );
  }


}

