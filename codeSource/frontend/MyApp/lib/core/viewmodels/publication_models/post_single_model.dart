import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/models/comment.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/locator.dart';
import 'package:MyApp/core/services/publication_service/pub_global_Src.dart';
import 'package:MyApp/core/services/publication_service/pub_reactions_Src.dart';
import 'package:MyApp/core/services/publication_service/pub_settings_Src.dart';
import 'package:MyApp/core/enum/PostSettingsEnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MyApp/ui/views/to_post_view.dart';

class SinglePostModel extends BaseModel {

  PublicationGlobalService _postGlobalService = locator<PublicationGlobalService>();
  PublicationSettingService _postSettingSrc = locator<PublicationSettingService>(); 
  PublicationReactionsService _postReactionsService = locator<PublicationReactionsService>();

  SETTINGCHOICES _choices;
  BuildContext   _context;
  Publication _publication;
  Employee _poster;
  bool _isHidden;
  Employee _user;
  List<Employee> _employeesWhoLiked;
  bool _isLiked;
  int _nbrOfLikes;
  int _nbrOfComments;
  TextEditingController _commentTextController;
  List<Comment> _comments;

  Publication    get publication => this._publication; 
  Employee       get poster      => this._poster;
  Employee       get user        => this._user;
  SETTINGCHOICES get choices     => this._choices;
  bool           get isHidden    => this._isHidden;
  bool           get isLiked     => this._isLiked;
  int            get nbrOfLikes  => this._nbrOfLikes;
  int            get nbrOfComments => this._nbrOfComments;
  List<Comment>  get comments    => this._comments;
  List<Employee> get employeesWhoLiked => this._employeesWhoLiked;
  TextEditingController get commentTextController => this._commentTextController;



  initData(Publication publication, Employee poster, Employee user, BuildContext context){
    this._publication = publication;
    this._poster      = poster;
    this._user        = user;
    this._context     = context;
    this._isHidden    = false;
    this._isLiked     = publication.likesIds.contains(user.id);
    this._nbrOfLikes  = publication.likesIds.length;
    this._nbrOfComments = publication.commentsIds.length;
  }

  Future getSinglePublication(String publicationId,Employee user) async {
    setState(ViewState.Busy);
    this._user=user;
    this._commentTextController = TextEditingController();
    this._publication = await this._postGlobalService.fetchSinglePost(publicationId);
    this._comments= await this._postReactionsService.getComments(publicationId);
    print('get Single publications from singleModel');
    setState(ViewState.Idle);
  }

  /// ************* Settings **************
  
List<PopupMenuItem<SETTINGCHOICES>> listOfChoices(){

    List<PopupMenuItem<SETTINGCHOICES>> mychoices = [
           PopupMenuItem(value: SETTINGCHOICES.HIDE,child: Text("Masquer"),)
       ];

if(this._poster.id == this._user.id){

  mychoices.addAll([
          PopupMenuItem(value: SETTINGCHOICES.MODIFY,child: Text("Modifier",style: TextStyle(fontFamily: "Times"))),
          PopupMenuItem(value: SETTINGCHOICES.REMOVE,child: Text("Supprimer",style: TextStyle(fontFamily: "Times")))
          ]);
  }

if(this._user.canApprove && this._user.agency.id == this._poster.agency.id){
  if(this._publication.isApproved){
     mychoices.add(PopupMenuItem(value: SETTINGCHOICES.APPROVE,child: Text("Disapprouver",style: TextStyle(fontFamily: "Times"))));
  }else{
     mychoices.add(PopupMenuItem(value: SETTINGCHOICES.APPROVE,child: Text("Approuver",style: TextStyle(fontFamily: "Times"))));
  }
}
    return mychoices;
} 



void applySettings(SETTINGCHOICES choice){

  switch(choice){
    case SETTINGCHOICES.APPROVE  : { print("Approuver est appelé"); approvePublication(); } break;
    case SETTINGCHOICES.REMOVE   : { print("remove est appelé")   ; removePublication();  } break;
    case SETTINGCHOICES.MODIFY   : { print("modify est appelé")   ; modifyPublication(); } break;
    case SETTINGCHOICES.HIDE     : { print("hide est appeale")    ; hidePublication(); } break;
  }

}


void removePublication() async {
  
 bool isRemoved = await this._postSettingSrc.deletePublication(this._publication.id);
 this._isHidden=isRemoved;
 notifyListeners();

 print("isRemoved : $isRemoved");

}

void approvePublication() async {
  this._publication.isApproved = ! this.publication.isApproved;
  bool isApp = await this._postSettingSrc.approvePublication(this._publication.id, this._publication.isApproved, this._user.id);
   notifyListeners();
  print("is Approved : $isApp");                     
}

void modifyPublication() async {
 Navigator.pop(this._context);
 Navigator.push(this._context, MaterialPageRoute(builder: (context) => ToPostView(post: this._publication))); 
}

void hidePublication() async {
  this._isHidden=true;
  notifyListeners();
}


/// *********** Réactions ****************
/// Likes
 onPressLikeIcon(){
    if(this.isLiked){
        this._nbrOfLikes--;
        removeLike();
        notifyListeners();
      }else{
        this._nbrOfLikes++;
        addLike();
        notifyListeners();
      }
    this._isLiked = ! this._isLiked;
  }

  void addLike() {
     this._postReactionsService.addLike(this._publication.id);
  }

  void removeLike() {
    this._postReactionsService.removeLike(this._publication.id);
  }

  Icon favoriteIcon() {
    return this.isLiked == false ? 
                           Icon(Icons.favorite_border, color: Colors.grey[400],size: 25.0,)
                          :
                           Icon(Icons.favorite, color: Colors.red[200],size: 25.0,);
  }

  Future getLikes(String publicationId) async {
    setState(ViewState.Busy);
    this._publication = await this._postReactionsService.getLikes(publicationId);
    this._employeesWhoLiked=this._publication.likesEmployees;
    setState(ViewState.Idle);
  } 

  /// Comments 
   addComment() async {
     print("Add Comment");
     Comment comment = Comment(text: this._commentTextController.text,commentator: this._user,date: DateTime.now());
     this._comments.add(comment);
     this._commentTextController.text=" ";
     notifyListeners();
     bool isAdded = await this._postReactionsService.addComment(this._publication.id, comment);
   }


}
