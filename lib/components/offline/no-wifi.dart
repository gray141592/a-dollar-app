import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoWifi extends StatelessWidget {
  const NoWifi({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'images/clarity_no-wifi-solid.svg',
      semanticsLabel: 'smajli',
    );
  }
}
