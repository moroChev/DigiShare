import 'Employee.dart';


class Agency{

  String id;
  String name;
  String address;
  String telephone;
  String email;
  String logo;
  Map<String, double> location;
  List<String> employeesIds;
  List<String> subsidiariesIds;
  List<Employee> employeesObjects;
  List<Agency> subsidiariesObjects;

  // Constructor
  Agency({this.id,this.name,this.address,this.telephone,this.email,this.logo,this.location,this.employeesIds,this.subsidiariesIds,this.employeesObjects,this.subsidiariesObjects});


  factory Agency.fromJsonWithoutEmployeesAndSubsidiaries(Map<String, dynamic> json){
    return Agency(
      id: json['_id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      telephone: json['telephone'] as String,
      email: json['email'] as String,
      logo: json['logo'] as String,
      location: {
        'lat': (json['location'] as Map<String,dynamic>)['lat'] as double,
        'lng': (json['location'] as Map<String,dynamic>)['lng'] as double
      },
      //employeesIds: (json['employees'] as List)?.map((e) => e as String)?.toList(),
      //subsidiariesIds: (json['subsidiaries'] as List)?.map((e) => e as String)?.toList()
    );
  }

  factory Agency.fromJsonWithSubsidiariesOnly(Map<String,dynamic> json){
    return Agency(
        id: json['_id'],
        name: json['name'] as String,
        address: json['address'] as String,
        telephone: json['telephone'] as String,
        email: json['email'] as String,
        logo: json['logo'] as String,
        location: {
          'lat': (json['location'] as Map<String,dynamic>)['lat'] as double,
          'lng': (json['location'] as Map<String,dynamic>)['lng'] as double
        },
        subsidiariesObjects: (json['subsidiaries'] as List)?.map((e) => Agency.fromJsonWithoutEmployeesAndSubsidiaries(e))?.toList()
    );
  }

  factory Agency.fromJsonWithEmployeesOnly(Map<String,dynamic> json){
    return Agency(
      id: json['_id'],
      name: json['name'] as String,
      address: json['address'] as String,
      telephone: json['telephone'] as String,
      email: json['email'] as String,
      logo: json['logo'] as String,
      location: {
        'lat': (json['location'] as Map<String,dynamic>)['lat'] as double,
        'lng': (json['location'] as Map<String,dynamic>)['lng'] as double
      },
      employeesObjects: (json['employees'] as List)?.map((e) => Employee.fromJsonWithoutPostsAndAgency(e))?.toList()
    );
  }

  @override
  String toString() {
    return 'Agency{id: $id, name: $name, address: $address, telephone: $telephone, email: $email, logo: $logo, location: $location, employeesIds: $employeesIds, subsidiariesIds: $subsidiariesIds, employeesObjects: $employeesObjects, subsidiariesObjects: $subsidiariesObjects}';
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