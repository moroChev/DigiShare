import 'package:MyApp/core/viewmodels/to_post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:MyApp/ui/shared/alertDialog.dart';

class CreateBtn extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
            height: 50,
            minWidth: MediaQuery.of(context).size.width/2 - 20,
            child: RaisedButton(
              color: Color(0xFF0DC1DD),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
              onPressed: ()async{
                print("created ...");
                bool hasError = await Provider.of<ToPostModel>(context, listen: false).onPressCreateBtn();
                if(hasError)
                OurAlertDialog(
                  title: 'Erreur',
                  content: 'erreur à l\'envoie',
                  btnsTextPath: {'Annuler':'/Home','réessayer':'/ToPostView'}
                  ).showMyDialog(context);
                else  
                OurAlertDialog(
                  title: 'Publication Envoyée',
                  content: 'votre publication a été ajouté avec succès il sera affiché une fois approuvé',
                  btnsTextPath: {'OK':'/Home'}).showMyDialog(context);
                },
              child: Text("Publier", textAlign: TextAlign.center),
        ),
     );
  }


}