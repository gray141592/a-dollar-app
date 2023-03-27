import 'package:flutter/material.dart';
import 'package:a_dollar_app/controllers/index.dart';
import 'package:provider/provider.dart';
import './smiley.dart';
import './countdown.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SuccessController>(builder: ((_, successController, __) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Smiley(
              canGoBack: !successController.hasAccess,
            ),
            Countdown(value: successController.timerText())
          ],
        ),
      );
    }));
  }
}
