import 'package:flutter/material.dart';
import 'package:scalable_flutter_app/screens/authentication/splashscreen.dart';
import 'package:scalable_flutter_app/services/navigation/routepaths.dart';

class Router{
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return _buildRoute(settings, SplashScreen());
      case signInScreen:
//        return _buildRoute(settings, SignInScreen());
      case registerScreen:
//        return _buildRoute(settings, RegisterScreen());
      case homeScreen:
//        return _buildRoute(settings, HomeScreen());
      default:
        return _buildRoute(settings, Scaffold(
              body: Center(
                child: Text("SCREEN NOT FOUND!"),
              ),
            ));
    }
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => screen,
    );
  }
}