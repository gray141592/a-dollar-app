import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'images/loading_screen.svg';
    return GestureDetector(
      child: SvgPicture.asset(
        assetName,
        semanticsLabel: 'Loading',
        fit: BoxFit.fill,
      ),
      onTap: () => Navigator.of(context).pushNamed('/home'),
    );
  }
}
