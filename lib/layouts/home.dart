import 'package:a_dollar_app/components/layout/index.dart';
import 'package:a_dollar_app/controllers/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:a_dollar_app/screens/index.dart';

class HomeLayout extends StatelessWidget {
  final Widget body;
  const HomeLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<NetworkController>(
        builder: ((_, networkController, __) {
          if (networkController.connected) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(),
                Expanded(
                  child: body,
                ),
                const Footer(),
              ],
            );
          } else {
            return const OfflineScreen();
          }
        }),
      ),
    );
  }
}
