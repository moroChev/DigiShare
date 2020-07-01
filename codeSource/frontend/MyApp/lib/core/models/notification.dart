import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';

class Notification{


  Notification({
    this.id,
    this.date,
    this.isSeen, 
    this.notifier, 
    this.notified,
    this.isChecked,
    this.publication, 
    this.notificationType
    });

  String id;
  String notificationType;
  Employee notifier;
  Employee notified;
  bool isChecked;
  bool isSeen;
  Publication publication;
  DateTime date;


  factory Notification.fromJson(Map<String,dynamic>json){
    print("trying to parse the notif");
      return Notification(
        id : json['_id'] as String,
        notificationType: json['notificationType'] as String,
        isChecked: json['isChecked'] as bool,
        isSeen: json['isSeen'] as bool,
        date: json['date'] == null ? null : DateTime.parse(json['date'].toString()),
        publication: json['publication'] == null ? null : Publication.fromJsonWithIdsNoObjects(json['publication']),
        notifier: json['notifier'] == null ? null: Employee.fromJsonWithoutPostsAndAgency(json['notifier'])
      ); 
  }

  @override
   String toString() => "Notif Id :$id , notifType : $notificationType , notifier : $notifier, isChecked : $isChecked";
  

}