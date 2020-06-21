import 'employee.dart';

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


  factory Agency.fromJsonWithIdsInLists(Map<String, dynamic> json){
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
      employeesIds: (json['employees'] as List)?.map((e) => e is String ? e : e['_id'] as String)?.toList(),
      subsidiariesIds: (json['subsidiaries'] as List)?.map((e) => e is String ? e : e['_id'] as String)?.toList()
    );
  }

  factory Agency.fromJsonWithObjectsInLists(Map<String,dynamic> json){
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
        subsidiariesObjects: (json['subsidiaries'] as List)?.map((e) => Agency.fromJsonWithIdsInLists(e))?.toList(),
        employeesObjects: (json['employees'] as List)?.map((e) => Employee.fromJsonWithoutPostsAndAgency(e))?.toList(),
    );
  }

  @override
  String toString() {
    return 'Agency{id: $id, name: $name, address: $address, telephone: $telephone, email: $email, logo: $logo, location: $location, employeesIds: $employeesIds, subsidiariesIds: $subsidiariesIds, employeesObjects: $employeesObjects, subsidiariesObjects: $subsidiariesObjects}';
  }
}