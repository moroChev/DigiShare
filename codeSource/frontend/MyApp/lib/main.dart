import 'package:MyApp/core/repositories/notifications_repo/notifications_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/models/employee.dart';
import 'ui/router.dart';
import 'core/services/authentication_service.dart';
import 'locator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  await DotEnv().load('.env');
  NotificationRepo.createSocket();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Employee>(
      initialData: Employee.initial(),
      create: (BuildContext context) => locator<AuthenticationService>().userController.stream,
      lazy: false,
      child: MaterialApp(
              title: 'Sign Up Screen ',
              theme: ThemeData(
                primarySwatch: Colors.teal,
                textTheme: TextTheme(body1: TextStyle( fontFamily: "Times" )),
              ),
              initialRoute: initialRoute,
              onGenerateRoute: Router.generateRoute,
      ),

    );
  }


}
