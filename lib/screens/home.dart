import 'package:flutter/material.dart';

import 'package:a_dollar_app/components/home/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[
          SizedBox(
            height: 40,
          ),
          HeroText(),
          SizedBox(
            height: 40,
          ),
          HeroCTA(),
        ],
      ),
    );
  }
}
