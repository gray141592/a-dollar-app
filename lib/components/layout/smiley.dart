import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Smiley extends StatelessWidget {
  const Smiley({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SvgPicture.asset(
          'images/smajli.svg',
          semanticsLabel: 'smajli',
        ),
      ),
      onTap: () => Navigator.of(context).maybePop(),
    );
  }
}
