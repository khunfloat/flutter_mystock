 import 'package:flutter/material.dart';
import 'package:my_stock/src/pages/pages.dart';

class AppRoute {
  static const homeRoute = "home";
  static const loginRoute = "logi";
  static const managementRoute = "management";

  final _route = <String, WidgetBuilder>{
    loginRoute : (context) => LoginPage(),
    homeRoute : (context) => HomePage(),
    managementRoute : (context) => ManagementPage(),
  };

  get getAll => _route;
}
