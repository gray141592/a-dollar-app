import 'package:flutter/material.dart';
import 'package:a_dollar_app/screens/index.dart';
import 'package:a_dollar_app/layouts/index.dart';

class Routes {
  static Widget homeRoute = const Layout(body: HomeScreen());
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/offline': (BuildContext context) => const Layout(body: OfflineScreen()),
    '/success': (BuildContext context) => const Layout(body: SuccessScreen()),
  };
}
