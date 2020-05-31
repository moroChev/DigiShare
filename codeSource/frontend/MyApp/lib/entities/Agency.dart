import 'dart:convert';

import 'package:signup_ui/entities/Employee.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'Agency.g.dart';

@JsonSerializable()
class Agency{
    
    String id;
    String name;
    String adress;
    String telephone;
    List<String> employees;

   // Constructeur 
    Agency({this.id,this.name,this.adress,this.telephone,this.employees});

 
    factory Agency.fromJsonWithoutEmployees(Map<String, dynamic> json){
      return Agency(
                 id: json['_id'],
                 name: json['name'] as String,
                 adress: json['adress'] as String,
                 telephone: json['telephone'] as String);
    }

}



// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

//   factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);

/* Agency _$AgencyFromJson(Map<String, dynamic> json) {
  return Agency(
    name: json['name'] as String,
    adress: json['adress'] as String,
    telephone: json['telephone'] as String,
    employees: (json['employees'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AgencyToJson(Agency instance) => <String, dynamic>{
      'name': instance.name,
      'adress': instance.adress,
      'telephone': instance.telephone,
      'employees': instance.employees,
    };
 */