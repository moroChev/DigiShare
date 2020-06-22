
import 'package:MyApp/ui/views/home_view.dart';
import 'package:MyApp/ui/views/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:MyApp/ui/views/to_post_view.dart';
import 'package:MyApp/ui/views/profil_view.dart';
import './views/agency_view.dart';
import 'views/login_view.dart';
import '../ui/views/home_view.dart';


const String initialRoute = "/SignIn";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView() );
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/Home':
        return MaterialPageRoute(builder: (_) => HomeView()) ;
      case '/Agency':
        return MaterialPageRoute(builder: (_) => AgencyView(id: settings.arguments));
      case '/Profil':
        return MaterialPageRoute(builder: (_) => ProfilView(idEmployee: settings.arguments));
       case '/ToPostView':
        return MaterialPageRoute(builder: (_) =>  ToPostView() ); 
      case '/Map':
        return MaterialPageRoute(builder: (_) => MapView());
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