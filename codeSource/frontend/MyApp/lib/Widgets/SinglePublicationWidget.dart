import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:strings/strings.dart';
import '../entities/Publication.dart';
import '../Screens/Profil.dart';
import '../entities/Employee.dart';

class SinglePublicationWidget extends StatefulWidget {
  Publication publication;
  Employee poster;

  SinglePublicationWidget({this.publication, this.poster}) {
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
            padding: const EdgeInsets.fromLTRB(18, 3, 18, 5),
            child: Text("${widget.publication?.content}"),
            //   child: Text("Random Text for description Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."),
          ),
          hasPostPicture(widget.publication?.imageUrl),
          Divider(
            indent: 20,
          ),
          Row(children: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                makeLike(),
                FlatButton(
                  child: Text(
                      "${widget.publication?.likesIds == null ? 0 : widget.publication.likesIds?.length} Likes"),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: Text(
                      "${widget.publication?.dislikesIds == null ? 0 : widget.publication.dislikesIds?.length} Dislikes"),
                  /*  */
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ]),
        ],
      ),
    );
    //   );
    //);
  }

  static Widget postHeader(Employee poster, BuildContext context) {
    ImageProvider _imageProvider = (poster?.imageUrl!=null) ? NetworkImage(poster?.imageUrl) : AssetImage( "asset/img/person.png");
    return ListTile(
        leading: FadeInImage(
          image: _imageProvider,
          placeholder: AssetImage('asset/img/person.png'),
        ),
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
                          builder: (context) => Profil(poster?.id)
                          ));
                }),
        ),
        subtitle: Text("Societe"),
        trailing: IconButton(icon: Icon(Icons.expand_more), onPressed: () {}));
  }

  static Widget makeLike() {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white)),
      child: Center(
        child: Icon(Icons.thumb_up, size: 12, color: Colors.white),
      ),
    );
  }

  Widget hasPostPicture(String image) {
    return (image != null)
        ? Padding(
            padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
            child: SizedBox(
              // child:
              child: Image.network(image),
              height: 190,
              width: MediaQuery.of(context).size.width * 90,
            ))
        : Text("");
  }
}
