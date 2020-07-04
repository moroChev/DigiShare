import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'employee.dart';

//part 'Publication.g.dart';

@JsonSerializable()
class Publication{
  
  static int nbrPosts=0;
  String id;
  bool isApproved;
  String content;
  String imageUrl;
  // on receive just IDs oof the employees
  Employee approvedBy;
  Employee postedBy;
  List<String> likesIds;
  List<Employee> likesEmployees;
  DateTime date;
  List<String> commentsIds;

  Publication({
               this.id,
               this.isApproved,
               this.content,
               this.imageUrl,
               this.approvedBy,
               this.postedBy,
               this.date, 
               this.likesIds, 
               this.likesEmployees,
               this.commentsIds
               });



    factory Publication.fromJson(Map<String, dynamic> json) {
          
        print("Publications From Json approuvedBy : ..... A .... ${json['_id']} and his index is : $nbrPosts");
            nbrPosts++;
        return Publication(
          id: json['_id'] as String,
          content: json['content'] as String,
          imageUrl: json['imageUrl'] as String,
          isApproved: json['isApproved'] as bool,
          approvedBy: json['approvedBy']==null ? null : Employee.fromJsonWithPostsIdAndAgency(json['approvedBy']),
          postedBy: json['postedBy']==null ? null : Employee.fromJsonWithPostsIdAndAgency(json['postedBy']),
          date: json['date'] == null ? null : DateTime.parse(json['date'].toString()),
          likesIds: (json['likes'] as List)?.map((e) => e as String)?.toList(),
          commentsIds: (json['comments'] as List)?.map((e) => e as String)?.toList()
        );
      }

              
      factory Publication.fromJsonWithIdsNoObjects(Map<String, dynamic> json) {
            
          print("Publications From Json approuvedBy : ..... A .... ${json['_id']} and his index is : $nbrPosts");
              nbrPosts++;
          return Publication(
            id: json['_id'] as String,
            content: json['content'] as String,
            imageUrl: json['imageUrl'] as String,
            isApproved: json['isApproved'] as bool,
            date: json['date'] == null ? null : DateTime.parse(json['date'].toString()),
            likesIds: (json['likes'] as List)?.map((e) => e as String)?.toList(),
            commentsIds: (json['comments'] as List)?.map((e) => e as String)?.toList(),
          );
        }


      factory Publication.fromJsonWithLikesObjects(Map<String,dynamic> json)
      {
          return Publication(
            id: json['_id'] as String,
            content: json['content'] as String,
            imageUrl: json['imageUrl'] as String,
            isApproved: json['isApproved'] as bool,
            date: json['date'] == null ? null : DateTime.parse(json['date'].toString()),
            likesEmployees: (json['likes'] as List)?.map((e) => Employee.fromJsonWithPostsIdAndAgency(e) )?.toList()
          );
      }  



      factory Publication.fromJsonWithoutEmployees(Map<String,dynamic> json){
        return Publication(
                    id: json['_id'] as String,
                    content: json['content'] as String,
                    imageUrl: json['imageUrl'] as String,
                    isApproved: json['isApproved'] as bool,
                    date: json['date'] == null ? null : DateTime.parse(json['date'].toString()),
        );
      }

    @override
    String toString() => "${this.isApproved} - ${this.content} - ${this.date} - posted by is : ${this.postedBy.toString()} ";

}



  

