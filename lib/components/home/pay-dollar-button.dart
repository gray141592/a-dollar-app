import 'package:flutter/material.dart';

class PayDollarButton extends StatelessWidget {
  const PayDollarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {Navigator.of(context).popAndPushNamed('/success')},
        child: const Text("Pay a dollar"));
  }
}
