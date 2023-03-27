import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Share extends StatelessWidget {
  const Share({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'images/facebook.svg',
              semanticsLabel: 'share',
            ),
            const SizedBox(
              width: 33,
            ),
            SvgPicture.asset(
              'images/instagram.svg',
              semanticsLabel: 'share',
            ),
            const SizedBox(
              width: 33,
            ),
            SvgPicture.asset(
              'images/twitter.svg',
              semanticsLabel: 'share',
            ),
            const SizedBox(
              width: 33,
            ),
            SvgPicture.asset(
              'images/linkedin.svg',
              semanticsLabel: 'share',
            ),
          ],
        )
      ],
    );
  }
}
