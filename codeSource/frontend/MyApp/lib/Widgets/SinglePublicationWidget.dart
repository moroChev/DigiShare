import 'package:MyApp/WebService/PublicationsController.dart';
//import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:strings/strings.dart';
import '../entities/Publication.dart';
import '../Screens/Profil.dart';
import '../entities/Employee.dart';

class SinglePublicationWidget extends StatefulWidget {
  Publication publication;
  Employee poster;
  // likes and dislikes vars are added to make real time change on the post without refrech the screen
  int likes;
  int dislikes;
  // these variable is here to an assure that 
  // the user gonna react to this publication once
  bool isCheked=false;
  

  SinglePublicationWidget({@required this.publication, @required this.poster}) {
    likes = this.publication?.likesIds?.length;
    dislikes = this.publication?.dislikesIds?.length;
    print(
        '---------------------Single publications widget called------------------------');
  }

  @override
  _SinglePublicationWidgetState createState() =>
      _SinglePublicationWidgetState();
}

class _SinglePublicationWidgetState extends State<SinglePublicationWidget> {

  @override
  Widget build(BuildContext context) {
    print(
        '---------------------Single publications widget called------------------------ \n publication gived is : ${widget.publication} and the guy who posted that is : ${widget.publication.postedBy}');
    return Container(
      margin: EdgeInsets.all(8.0),
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          postHeader(widget.poster, context),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 3, 18, 5),
            child: Text("${widget.publication?.content}"),
            ),
          hasPostPicture(widget.publication?.imageUrl),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
         reactionRow(),

        ],
      ),
    );
  }

// row of reactions some reaction gonna be added soon
   Widget reactionRow(){
    return Row(children: <Widget>[  
          loveButton(),
          ]);
  }

// love button still need work : i have to remove like when dislike is hinted so i neeed userId and publiction id to do so
   Widget loveButton(){
     Icon favoriteIcon   = widget.isCheked==false 
                         ? Icon(
                            Icons.favorite_border,
                            color: Colors.grey[400],
                            size: 25.0,
                            )
                          :
                           Icon(
                            Icons.favorite,
                            color: Colors.red[300],
                            size: 25.0,
                            );
    return    FlatButton.icon(
                  color: Colors.blue[60],
                  icon:  favoriteIcon,
                  onLongPress: (){},
                  label: Text(
                      "${widget.likes}",style: TextStyle(color: Colors.grey[400]),),
                  onPressed: () { 
                      print("this post isn't reacted yet !");
                      setState(() {
                     if(!widget.isCheked){ 
                       PublicationsController.likePublication(widget.publication?.id); 
                          widget.likes++;
                          widget.isCheked=true;
                       } else{
                       PublicationsController.dislikePublication(widget.publication?.id); 
                       widget.likes--;
                       widget.isCheked=false;
                        }
                         });
                  }
                );
  }

// i use this the method just to customize the listTile Image
 Widget _imageForListTile(String imageUrl){
    ImageProvider _imageProvider = (imageUrl!=null) ? NetworkImage(imageUrl) : AssetImage( "asset/img/person.png");
    return   Container(
        height: 80.0,
        width: 60.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: _imageProvider,
            ),
            border: Border.all(color: Colors.white, width: 1.0)),
      );
  } 


// it is the post header in forme of a listTile 
// so it has the profil picture and FullName and the society name
   Widget postHeader(Employee poster, BuildContext context) {
    return ListTile(
        leading: _imageForListTile(poster?.imageUrl),
        title: RichText(
          text: TextSpan(
              text: capitalize("${poster?.firstName}") +
                  " " +
                  capitalize("${poster?.lastName}"),
              style: TextStyle(color: Colors.black),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print(
                      "trying to go the profil ... ${poster?.firstName} and my id is : ${poster?.id}");
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Profil(employeeID: poster?.id)
                          ));

                }),
        ),
        subtitle: Text("${poster?.agency?.name}"),
        trailing: IconButton(icon: Icon(Icons.expand_more), onPressed: () {}));
  }


//this method ih here to display a post picture if it's exist 
  Widget hasPostPicture(String image) {
    return (image != null)
        ?   Container(
        height: 170.0,
        width: 280.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(image),

            ),
            border: Border.all(color: Colors.white, width: 1.0)),
      )
        : Text("");
  }






}
