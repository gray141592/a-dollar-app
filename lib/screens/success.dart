import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Congratulations! You are the',
          ),
          Text(
            '202,031',
            style: Theme.of(context).textTheme.headline4,
          ),
          const Text(
            'curious person.',
          ),
        ],
      ),
    );
  }

  String currentTime() {
    var stringList = DateTime.now().toIso8601String().split(RegExp(r"[T\.]"));
    return "${stringList[0]} ${stringList[1]}";
  }
}
