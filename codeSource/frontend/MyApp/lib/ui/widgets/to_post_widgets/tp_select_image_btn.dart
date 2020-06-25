import 'package:MyApp/core/viewmodels/to_post_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SelectImageBtn extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
              height: 50,
              width: 160,
              child: RaisedButton(
                color: Color(0xFF303960),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: () { 
                   Provider.of<ToPostModel>(context,listen: false).getImage(ImageSource.gallery);
                  },
                child: Text("Selectionner image"),
              ),
    );
  }
}