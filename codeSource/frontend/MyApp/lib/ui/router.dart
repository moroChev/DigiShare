import 'package:MyApp/Screens/Home.dart';
import 'package:MyApp/Screens/Profil.dart';
import 'package:MyApp/Screens/ToPostScreen.dart';
import 'package:MyApp/ui/views/home_view.dart';
import 'package:MyApp/ui/views/profile_view.dart';
import 'package:MyApp/ui/views/to_post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './views/agency_view.dart';
import 'views/login_view.dart';


const String initialRoute = "/SignIn";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => /* HomeView() */ Home());
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/Home':
        return MaterialPageRoute(builder: (_) => /* HomeView() */ Home());
      case '/Agency':
        return MaterialPageRoute(builder: (_) => AgencyView(id: settings.arguments));
      case '/Profile':
        return MaterialPageRoute(builder: (_) => /* ProfileView(id: settings.arguments) */ Profil(employeeID: settings.arguments));
      case '/ToPostScreen':
        return MaterialPageRoute(builder: (_) => /* ToPostView() */ ToPostScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
        );
    }
  }
}