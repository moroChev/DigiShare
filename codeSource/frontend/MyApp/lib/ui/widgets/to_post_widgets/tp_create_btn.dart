import 'package:MyApp/core/viewmodels/to_post_model.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class CreateBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ToPostModel>(
      builder: (context,model,child)
        =>ButtonTheme(
            height: 50,
            minWidth: 140,
            child: RaisedButton(
              color: Color(0xFF0DC1DD),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
              onPressed: ()async{
                bool isCreated = await model.onPressCreateBtn();
                },
                child: Text("Publier"),
            ),
                ),
    );
  }
}