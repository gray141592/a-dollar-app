import 'package:a_dollar_app/theme.dart';
import 'package:flutter/material.dart';

class PayDollarButton extends StatelessWidget {
  const PayDollarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/success');
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: DollarTheme.orangeText),
          ),
        ),
        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
        minimumSize: const MaterialStatePropertyAll<Size>(Size.fromHeight(50)),
      ),
      child: Text(
        "Pay now",
        style: TextStyle(
          color: DollarTheme.orangeText,
        ),
      ),
    );
  }
}
