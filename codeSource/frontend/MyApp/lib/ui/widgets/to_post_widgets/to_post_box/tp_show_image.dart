import 'package:MyApp/core/viewmodels/to_post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowImage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ( Provider.of<ToPostModel>(context,listen: false).imageToDisplay != null)
        ? Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.cancel,size: 20,),
                  onPressed: (){
                    Provider.of<ToPostModel>(context,listen: false).onPressCancelIcon();
                   }
                  )
              ],
              ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[     
                   SizedBox(
                    height: 240,
                    width: 320,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, top: 0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.white, width: 1.0)),
                      child: Provider.of<ToPostModel>(context,listen: false).imageToDisplay,
                      ),
                    ),
                  ],
              ),
          ],
        )
        : Container(height: 0,width: 0,);
      }
}