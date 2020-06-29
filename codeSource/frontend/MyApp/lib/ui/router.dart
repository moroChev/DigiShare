import 'package:MyApp/ui/views/chat_users_view.dart';
import 'package:MyApp/ui/views/chat_view.dart';
import 'package:MyApp/ui/views/home_view.dart';
import 'package:MyApp/ui/views/messages_view.dart';
import 'package:MyApp/ui/views/to_post_view.dart';
import 'package:MyApp/ui/views/map_view.dart';
import 'package:MyApp/ui/views/profil_view.dart';
import 'package:MyApp/ui/views/agency_view.dart';
import 'package:MyApp/ui/views/login_view.dart';
import 'package:MyApp/ui/views/notifications_view.dart';
import 'package:MyApp/ui/views/single_post_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


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
      case '/Messages':
        return MaterialPageRoute(builder: (_) => MessagesView());
      case '/ChatUsers':
        return MaterialPageRoute(builder: (_) => ChatUsersView());
      case '/Chat':
        return MaterialPageRoute(builder: (_) => ChatView(toChatUser: settings.arguments));
      case '/Notifications':
      return MaterialPageRoute(builder: (_) => NotificationsView());
      case '/SinglePostView':
      return MaterialPageRoute(builder: (_) => SinglePostView(publicationId: settings.arguments));
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