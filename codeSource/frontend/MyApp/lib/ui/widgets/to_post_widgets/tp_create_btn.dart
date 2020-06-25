import 'package:MyApp/core/viewmodels/to_post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
            height: 50,
            minWidth: 140,
            child: RaisedButton(
              color: Color(0xFF0DC1DD),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
              onPressed: ()async{
                print("created ...");
                bool hasError = await Provider.of<ToPostModel>(context, listen: false).onPressCreateBtn();
                if(!hasError)  Navigator.pushReplacementNamed(context, '/Home');
               // else  Navigator.pushReplacementNamed(context, '/Home');
                print('hasError $hasError');
                },
              child: Text("Publier"),
        ),
     );
  }
}