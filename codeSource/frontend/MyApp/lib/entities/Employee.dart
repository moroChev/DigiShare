import 'dart:convert';

import 'package:flutter/cupertino.dart';

import './Publication.dart';
import './Agency.dart';

import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()

class Employee{
    

    String id;
    List<String> publicationsIds;
    List<Publication> publicationsObjects;
    String firstName;
    String lastName;
    String imageUrl;
    String email;
    String position;
    bool canApprove;
    Agency agency;


    Employee({this.id,this.publicationsObjects,this.publicationsIds,this.imageUrl,this.firstName,this.lastName,this.email,this.position,this.canApprove,this.agency});
    
    
    factory Employee.fromJsonWithoutPostsAndAgency(Map<String, dynamic> json){

      print("we are in Employee from json without posts and agency objects ");

     return Employee(
        id: json['_id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        imageUrl: json['imageUrl'] as String,
        email: json['email'] as String,
        position: json['position'] as String,
        canApprove: json['canApprove'] as bool
        );

    }

    factory Employee.fromJsonWithPostsAndAgencyObjects(Map<String,dynamic> json){

       print("we are in Employee from json with posts and agency objects ");
       return Employee(
              id: json['_id'] as String,   
              publicationsObjects: (json['publications'] as List)?.map((e) => Publication.fromJsonWithIdsNoObjects(e))?.toList(),
              imageUrl: json['imageUrl'] as String,
              firstName: json['firstName'] as String,
              lastName: json['lastName'] as String,
              email: json['email'] as String,
              position: json['position'] as String,
              canApprove: json['canApprove'] as bool,
              agency: json['agency'] == null
                  ? Agency()
                  : Agency.fromJsonWithoutEmployeesAndSubsidiaries(json['agency'] as Map<String, dynamic>),
            );

    }

    factory Employee.fromJsonWithPostsIdAndAgency(Map<String, dynamic> json) {
      print("we are in Employee from json with posts IDs and agency object ${json['agency']['name']} ");
          return Employee(
              id: json['_id'] as String,   
              publicationsIds: (json['publications'] as List)?.map((e) => e as String)?.toList(),
              imageUrl: json['imageUrl'] as String,
              firstName: json['firstName'] as String,
              lastName: json['lastName'] as String,
              email: json['email'] as String,
              position: json['position'] as String,
              canApprove: json['canApprove'] as bool,
              agency: json['agency'] == null
                  ? Agency()
                  : Agency.fromJsonWithoutEmployeesAndSubsidiaries(json['agency'] as Map<String, dynamic>),
            );
    }

   @override
   String toString() => "firstName : ${this.firstName} lastName: ${this.lastName} email: ${this.email} and imageUrl : ${this.imageUrl} and agencyName: ${this.agency?.name}";

  


}

