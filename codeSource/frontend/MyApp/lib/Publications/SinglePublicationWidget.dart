import 'package:MyApp/WebService/PublicationsController.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:provider/provider.dart';
import './Widgets/LikesWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './Widgets/EmployeeListTilePub.dart';
import '../WebService/NetworkImageController.dart';

class SinglePublicationWidget extends StatefulWidget {
  final Publication publication;
  final Employee poster;
  
  

  SinglePublicationWidget({@required this.publication, @required this.poster}) {
    
    print('---------------------Single publications widget called------------------------');
  }

  @override
  _SinglePublicationWidgetState createState() =>
      _SinglePublicationWidgetState();
}

class _SinglePublicationWidgetState extends State<SinglePublicationWidget> {

  // likes vars are added to make real time change on the post without refrech the screen
  List<String>likesList;
  int nbrOfLikes;
  // these variable is here to an assure that 
  // the user gonna react to this publication once
  bool isCheked=false;

   
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      likesList   = widget.publication?.likesIds;
      nbrOfLikes  = widget.publication?.likesIds?.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    // receiving the user id here from the inherited widget
    isCheked = widget.publication?.likesIds?.contains(Provider.of<Employee>(context).id);

    print('---------------Single publications widget called------- publication gived is : ${widget.publication.id} and the guy who posted that is : ${widget.publication.postedBy} and  the user id is : ${Provider.of<Employee>(context).id}');
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5),spreadRadius: 5,blurRadius: 7, offset: Offset(0, 3),),],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
         // postHeader(widget.poster, context),
          EmployeeListTilePub(employee: widget.poster, publication: widget.publication),
          rowOfContent(widget.publication?.content),
          buildPostImage(widget.publication?.imageUrl),
          Divider(indent: 20,endIndent: 20,),
          reactionRow(context),

        ],
      ),
    );
  }

// this row is here to display the post's content which is a text 
  Widget rowOfContent(String content)
  {
    String myContent = content ?? ""; 
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(32, 3, 18, 10),
          width: 335,
          child: Text("$myContent",style:TextStyle(fontFamily: "Times"),overflow: TextOverflow.ellipsis,maxLines: 5,),
            ),
           ],
      );
  }

// row of reactions some reaction gonna be added soon
   Widget reactionRow(BuildContext context){
    return Row(
            children: <Widget>[       
             loveButton(context),
             ]
            );
  }
// this method uses isCheked variable for hundling the likes logic 
// so by default ischeked = false means that this user hasn't yet like that post
// once the user press the icon setState method is called to get the process done
   Widget loveButton(BuildContext context){
     Icon favoriteIcon   = isCheked == false ? 
                           Icon(Icons.favorite_border, color: Colors.grey[400],size: 25.0,)
                          :
                           Icon(Icons.favorite, color: Colors.red[200],size: 25.0,);
        return FlatButton.icon(
                  color: Colors.blue[60],
                  icon:  favoriteIcon,
                  onLongPress: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LikesWidget(publicationId: widget.publication?.id)));
                  },
                  label: Text("$nbrOfLikes",style: TextStyle(color: Colors.grey[400],fontFamily: "Times"),),
                  onPressed: () { 
                      print("this post isn't reacted yet !");
                      setState(() {
                     if(!isCheked){ 
                       print("isChecked is not true so it s a new like ... and who is liking it is ${Provider.of<Employee>(context).id}");
                       PublicationsController.addLikePublication(widget.publication?.id); 
                          nbrOfLikes++;
                          isCheked=true;
                          widget.publication?.likesIds?.add(Provider.of<Employee>(context).id);
                    } else{
                         print("isChecked is true so it s a dislike ...");
                       PublicationsController.removeLikePublication(widget.publication?.id); 
                          nbrOfLikes--;
                          isCheked=false;
                          widget.publication?.likesIds?.removeWhere((element) => element==Provider.of<Employee>(context).id);
                        }
                         });
                  }
                );
  }


// this method is here to fetch the image from the network 
// then it use postPictureCutsomized method for customize the style 
 Widget buildPostImage(String imageUrl){
   return FutureBuilder(
      future: NetworkImageController.fetchImage(imageUrl),
      builder: (BuildContext context, AsyncSnapshot<NetworkImage> image) {
        if (image.hasData) {return postPictureCustomized(image.data);}
        else {return Text("");}
      }
    );
  }



//this method ih here to display a post picture if it's exist with customized style   
  Widget postPictureCustomized(NetworkImage imageFromNetwork) {
    return Container(
        height: 170.0,
        width: 280.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageFromNetwork,
            ),
            border: Border.all(color: Colors.white, width: 1.0)),
      );
  }










}
