import 'package:flutter/material.dart';

class NavigationService{
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  bool pop(value) {
    return _navigationKey.currentState.pop(value);
  }
  Future<dynamic> pushNamed(String routeName, List arguments){
    return _navigationKey.currentState.pushNamed(routeName,arguments:arguments);
  }
  Future<dynamic> pushReplacementName(String routeName){
    return _navigationKey.currentState.pushReplacementNamed(routeName);
  }
}