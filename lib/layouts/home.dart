import 'package:a_dollar_app/components/layout/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:a_dollar_app/screens/index.dart';

class HomeLayout extends StatelessWidget {
  final Widget body;
  const HomeLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
        child: Container(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Smiley(),
                Expanded(
                  child: body,
                ),
                const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
