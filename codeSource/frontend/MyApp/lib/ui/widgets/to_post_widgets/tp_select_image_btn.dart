
import 'package:MyApp/core/viewmodels/to_post_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:MyApp/ui/views/base_view.dart';



class SelectImageBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ToPostModel>(
        //  onModelReady: (model)=>model,
          builder:(context,model,child)=> Container(
              height: 50,
              width: 160,
              child: RaisedButton(
                color: Color(0xFF303960),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: () { model.getImage(ImageSource.gallery);},
                child: Text("Selectionner image"),
              ),
           ),
    );
  }
}