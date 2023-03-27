import 'package:a_dollar_app/components/success/index.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SuccessHero(),
              SizedBox(
                height: 40,
              ),
              Share(),
            ],
          ),
          const ConfettiExplosion(),
        ],
      ),
    );
  }

  String currentTime() {
    var stringList = DateTime.now().toIso8601String().split(RegExp(r"[T\.]"));
    return "${stringList[0]} ${stringList[1]}";
  }
}
