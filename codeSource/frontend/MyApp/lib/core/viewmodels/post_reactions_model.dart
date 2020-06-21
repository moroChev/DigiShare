import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/services/publication_service.dart';
import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:flutter/cupertino.dart';
import 'base_model.dart';
import '../../locator.dart';
import 'package:flutter/material.dart';


class PostReactionsModel extends BaseModel{

  final PublicationService _postService = locator<PublicationService>();
  List<Employee> _employeesWhoLiked;
  Publication thePost;
  bool isLiked;
  int nbrOfLikes;

  List<Employee> get employeesWhoLiked => this._employeesWhoLiked;


   initData(Publication post, userId){
        thePost = post;
        isLiked = post.likesIds.contains(userId);
        nbrOfLikes = post.likesIds.length;
  } 


  onPressLikeIcon(){
    if(this.isLiked){
        nbrOfLikes--;
        removeLike();
        notifyListeners();
      }else{
        nbrOfLikes++;
        addLike();
        notifyListeners();
      }
    this.isLiked = ! this.isLiked;
  }

  void addLike() {
     this._postService.addLike(this.thePost.id);
  }

  void removeLike() {
    this._postService.removeLike(this.thePost.id);
  }

  Icon favoriteIcon() {
    return this.isLiked == false ? 
                           Icon(Icons.favorite_border, color: Colors.grey[400],size: 25.0,)
                          :
                           Icon(Icons.favorite, color: Colors.red[200],size: 25.0,);
  }

  Future getLikes(String publicationId) async {
    setState(ViewState.Busy);
    this.thePost = await this._postService.getLikes(publicationId);
    this._employeesWhoLiked=thePost.likesEmployees;
    setState(ViewState.Idle);
  }

}