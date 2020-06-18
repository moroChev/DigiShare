import 'package:MyApp/core/models/employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  final String id;

  ProfileView({@required this.id});

  @override
  Widget build(BuildContext context) {
    // if no parameter passed to this view , by default we display the logged in user's profile
    //else we consider user's id parameter
    var userId = id == null ? Provider.of<Employee>(context).id : id;
    // in the rest of this view we will use userId variable instead of id
    return Container();
  }
}
