import 'package:flutter/material.dart';
import 'package:MyApp/ui/views/to_post_view.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Color(0xFF0DC1DD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(Icons.add, color: Colors.blueGrey[100],),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ToPostView())); 
        });
  }
}