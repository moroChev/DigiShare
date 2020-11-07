import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MyApp/core/models/comment.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_image.dart';
import 'package:strings/strings.dart';
import 'package:MyApp/core/viewmodels/publication_models/post_single_model.dart';
import 'package:provider/provider.dart';
import 'package:MyApp/core/enum/PostSettingsEnum.dart';

class PostCommentTile extends StatelessWidget {

  final Comment comment;
  PostCommentTile({@required this.comment});

  @override
  Widget build(BuildContext context) {
    Employee user = Provider.of<Employee>(context);
    return ListTile(
              dense: true,
              leading: EmployeeImage(imageUrl: this.comment.commentator.imageUrl),
              title: Text(
                  capitalize(this.comment.commentator.firstName + " " + this.comment.commentator.lastName),
                  style: TextStyle(color: Colors.black, fontFamily: "Times")
                  ), 
              isThreeLine: true,
              trailing: (this.comment.commentator.id == user.id) ? commentSettings(Provider.of<SinglePostModel>(context, listen: false)) : Text(" "),
              subtitle: Container(
                child: Text("${this.comment.text}"),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFf3f6f8)
                ),
              ),
          );
  }

  
Widget commentSettings(SinglePostModel model){
  return PopupMenuButton<COMMENTSETTING>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          icon: Icon(Icons.more_vert),
          onSelected: model.onTapCommentSettings,
          itemBuilder: (BuildContext context){
            return model.commentSettingsChoices(comment);
          }
  );
}






}