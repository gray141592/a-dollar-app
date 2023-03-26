import 'package:a_dollar_app/components/offline/index.dart';
import 'package:a_dollar_app/theme.dart';
import 'package:flutter/material.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DollarTheme.cream,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Woops(),
          NoWifi(),
          SizedBox(
            height: 20,
          ),
          Text(
            'No connection',
          ),
        ],
      ),
    );
  }
}
