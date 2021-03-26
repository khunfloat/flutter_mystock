 import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_stock/src/pages/pages.dart';

class AppRoute {
  static const homeRoute = "home";
  static const loginRoute = "login";
  static const managementRoute = "management";
  static const mapRoute = "map";

  final _route = <String, WidgetBuilder>{
    loginRoute : (context) => LoginPage(),
    homeRoute : (context) => HomePage(),
    managementRoute : (context) => ManagementPage(),
    mapRoute : (context) => GoogleMapPage(),
  };

  get getAll => _route;
}
