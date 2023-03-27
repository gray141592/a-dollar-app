import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a_dollar_app/controllers/index.dart';

class PurchaseCount extends StatelessWidget {
  const PurchaseCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseController>(
      builder: ((_, firebaseController, __) => Text(
            firebaseController.countFormatted(),
            style: const TextStyle(
              fontFamily: 'Boris',
              fontSize: 72,
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}
