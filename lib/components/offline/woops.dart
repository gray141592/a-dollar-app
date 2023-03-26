import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Woops extends StatelessWidget {
  const Woops({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'images/woops.svg',
      semanticsLabel: 'smajli',
    );
  }
}
