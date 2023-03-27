import 'package:a_dollar_app/theme.dart';
import 'package:flutter/material.dart';

import 'purchase-count.dart';

class SuccessHero extends StatelessWidget {
  const SuccessHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DollarTheme.cream,
      child: SizedBox(
        height: 225,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You are the:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 5,
            ),
            const PurchaseCount(),
            const SizedBox(
              height: 5,
            ),
            Text(
              "curious person!",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
