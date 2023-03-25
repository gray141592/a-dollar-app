import 'package:flutter/material.dart';

import 'package:a_dollar_app/components/home/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'Pay a dollar',
          ),
          PayDollarButton()
        ],
      ),
    );
  }
}
