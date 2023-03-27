import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Smiley extends StatelessWidget {
  final bool canGoBack;
  const Smiley({this.canGoBack = true, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SvgPicture.asset(
        'images/smajli.svg',
        semanticsLabel: 'smajli',
      ),
      onTap: () => canGoBack ? Navigator.of(context).maybePop() : null,
    );
  }
}
