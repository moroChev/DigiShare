import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/services/publication_service.dart';
import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:MyApp/locator.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:MyApp/core/enum/PostSettingsEnum.dart';
import 'package:MyApp/core/enum/viewstate.dart';

class ToPostModel extends BaseModel{
  
  final                 _picker             = ImagePicker();
  PublicationService    _publicationService = locator<PublicationService>();
  TextEditingController _contentController  = TextEditingController();
  bool                  _hasError           = false;
  Image                 _imageTodDisplay;
  bool                  _isNewPost;
  File                  _image;
  Publication           _post;
  Employee              _user;


  TextEditingController get contentController => this._contentController;
  Publication           get publication => this._post;
  Employee              get user => this._user;
  Image                 get imageToDisplay => this._imageTodDisplay;


 initData(Publication post, Employee user){
   setState(ViewState.Busy);
      _post=post;
      _isNewPost = ( post?.imageUrl == null && post?.content == null );
      _imageTodDisplay= post?.imageUrl == null ? null : Image.network(post?.imageUrl, height: 220, width: 350);
      _contentController.text = post?.content;
      _user = user;
      print('init data ... ${this._user.agency}');
      notifyListeners();
      setState(ViewState.Idle);
 }


  getImage(ImageSource source) async {
  final pickedImage      = await _picker.getImage(source: source);
        _image           = File(pickedImage.path);
        _imageTodDisplay =  Image.file( _image, height: 220, width: 350);
      notifyListeners();
  }

  Publication constructThePost({String content}){
    if(this._post!=null){
      this._post.content=content;
      return this._post;
    }else{
      return Publication(content: content, postedBy: this._user);
    }
  }
 
  Future<bool> onPressCreateBtn() async {
   Publication publication = constructThePost(content: _contentController.text);
   print("onPresse createBtn ${_contentController.text}");
            bool isCreated = await _publicationService
                                      .postPublication(
                                        publication: publication,
                                        imageUrl: _image,
                                        requestType: _isNewPost ? RequestChoices.CREATE : RequestChoices.MODIFY
                                        );
    this._hasError         = ! isCreated ;
    notifyListeners();
    return this._hasError;
  }
              





}