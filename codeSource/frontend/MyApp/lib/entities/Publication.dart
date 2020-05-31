import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import './Employee.dart';

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
  List<String> dislikesIds;
  List<Employee> likesEmployees;
  List<Employee> dislikesEmployees;
  String date;

  Publication({this.id,this.isApproved, this.content, this.imageUrl, this.approvedBy, this.postedBy ,this.date, this.likesIds, this.dislikesIds, this.likesEmployees,this.dislikesEmployees} );



           factory Publication.fromJson(Map<String, dynamic> json) {
                  
                print("Publications From Json approuvedBy : ..... A .... ${json['_id']} and his index is : $nbrPosts");
                   nbrPosts++;
                return Publication(
                  isApproved: json['isApproved'] as bool,
                  id: json['_id'] as String,
                  content: json['content'] as String,
                  imageUrl: json['imageUrl'] as String,
                  approvedBy: json['approvedBy']==null ? null : Employee.fromJsonWithoutPostsAndAgency(json['approvedBy']),
                  postedBy: json['postedBy']==null ? null : Employee.fromJsonWithoutPostsAndAgency(json['postedBy']),
                  date: json['date'] as String,
                  likesIds: (json['likes'] as List)?.map((e) => e as String)?.toList(),
                  dislikesIds: (json['dislikes'] as List)?.map((e) => e as String)?.toList(),
                );
              }



            factory Publication.fromJsonWithoutEmployees(Map<String,dynamic> json){
              return Publication(
                          id: json['_id'] as String,
                          isApproved: json['isApproved'] as bool,
                          content: json['content'] as String,
                          imageUrl: json['imageUrl'] as String,
                          date: json['date'] as String
              );

            }

    @override
    String toString() => "${this.isApproved} - ${this.content} - ${this.date} - posted by is : ${this.postedBy.toString()} ";

}


/* 
  factory Publication.fromJson(Map<String, dynamic> json) {
                  
                print("Publications From Json approuvedBy : ..... A .... ");

                return Publication(
                  isApproved: json['isApproved'] as bool,
                  content: json['content'] as String,
                  imageUrl: json['imageUrl'] as String,
                  approvedBy: json['approvedBy'] == null
                      ? Employee()
                      : Employee.fromJsonWithoutPostsAndAgency(json['approvedBy'] as Map<String, dynamic>),
                  postedBy: json['postedBy'] == null
                      ? Employee()
                      : Employee.fromJsonWithoutPostsAndAgency(json['postedBy'] as Map<String, dynamic>),
                  date: json['date'] as String,
                  likes: (json['likes'] as List)?.map((e) => e as String)?.toList(),
                  dislikes: (json['dislikes'] as List)?.map((e) => e as String)?.toList(),
                );
}


  factory Publication.fromJsonWithoutEmployees(Map<String,dynamic> json){
    return Publication(
                isApproved: json['isApproved'] as bool,
                content: json['content'] as String,
                imageUrl: json['imageUrl'] as String,
                date: json['date'] as String
    );

  }

    @override
    String toString() => "${this.isApproved} - ${this.content} - ${this.date} - posted by is : ${this.postedBy.toString()} ça marche";

 */

  

