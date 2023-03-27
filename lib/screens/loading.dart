import 'package:a_dollar_app/theme.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'images/landing.png';
    return GestureDetector(
      child: Container(
        color: DollarTheme.orangeText,
        child: Image.asset(
          assetName,
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed('/home'),
    );
  }
}
