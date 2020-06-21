import 'package:MyApp/core/viewmodels/to_post_model.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BaseView<ToPostModel>(
      builder: (context,model,child)=> ( model.imageToDisplay != null)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[     
              SizedBox(
                height: 240,
                width: 320,
                child: Container(
                  padding: EdgeInsets.only(bottom: 10, top: 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.white, width: 1.0)),
                  child: model.imageToDisplay,
                  ),
                ),
              ],
          )
        : Container(height: 0,width: 0,),
    );
  }
}