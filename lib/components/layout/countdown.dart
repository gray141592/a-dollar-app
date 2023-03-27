import 'package:a_dollar_app/theme.dart';
import 'package:flutter/material.dart';

class Countdown extends StatelessWidget {
  final String value;
  const Countdown({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
          fontFamily: 'Boris', fontSize: 12, color: DollarTheme.pinkText),
    );
  }
}
