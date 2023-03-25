import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:a_dollar_app/screens/index.dart';

class Layout extends StatelessWidget {
  final Widget body;
  const Layout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("A dollar app"),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return child;
          }
          return const OfflineScreen();
        },
        child: body,
      ),
    );
  }
}
