import 'package:MyApp/core/models/employee.dart';

class Comment{

  Comment({
    this.id,
    this.text,
    this.commentator,
    this.date,
    this.publicationId
  });

  String id;
  String text;
  Employee commentator;
  DateTime date;
  String publicationId;


  factory Comment.fromJson(Map<String,dynamic> json){
    return Comment(
      id: json['_id'] as String,
      text: json['text'] as String,
      publicationId: json['publication'] as String,
      date: json['date'] == null ? null : DateTime.parse(json['date'].toString()),
      commentator: json['commentator'] == null ? null : Employee.fromJsonWithPostsIdAndAgency(json['commentator'] as Map<String,dynamic>),
    );
  }

  @override
  String toString() => "Comment => id: $id text: $text commentator: $commentator publicationId: $publicationId";
  
}