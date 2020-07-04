import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MyApp/core/models/comment.dart' as myComment;
import 'package:MyApp/ui/shared/emp_list_tile/employee_image.dart';
import 'package:strings/strings.dart';

class PostCommentTile extends StatelessWidget {

  final myComment.Comment comment;
  PostCommentTile({@required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: EmployeeImage(imageUrl: this.comment.commentator.imageUrl),
      title: Text(
          capitalize(this.comment.commentator.firstName + " " + this.comment.commentator.lastName),
          style: TextStyle(color: Colors.black, fontFamily: "Times")),
      isThreeLine: true,
      trailing: Icon(Icons.more_horiz),
      subtitle: Container(
        child: Text("${this.comment.text}"),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFf3f6f8)
        ),
      ),
    );
  }
}