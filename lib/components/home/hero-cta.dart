import 'package:a_dollar_app/theme.dart';
import 'package:flutter/material.dart';
import 'fake-pay-dollar-button.dart';

class HeroCTA extends StatelessWidget {
  const HeroCTA({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: DollarTheme.orangeText),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Curious to see how many people paid a dollar?",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 40,
          ),
          const PayDollarButton(),
        ],
      ),
    );
  }
}
