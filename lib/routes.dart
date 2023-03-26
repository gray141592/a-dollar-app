import 'package:flutter/material.dart';
import 'package:a_dollar_app/screens/index.dart';
import 'package:a_dollar_app/layouts/index.dart';

class Routes {
  static Widget homeRoute = const FullScreenLayout(body: LoadingScreen());
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/home': (BuildContext context) => const HomeLayout(body: HomeScreen()),
    '/offline': (BuildContext context) => const HomeLayout(body: OfflineScreen()),
    '/success': (BuildContext context) => const HomeLayout(body: SuccessScreen()),
  };
}
