import 'package:a_dollar_app/controllers/index.dart';
import 'package:a_dollar_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayDollarButton extends StatefulWidget {
  const PayDollarButton({super.key});

  @override
  State<PayDollarButton> createState() => _PayDollarButtonState();
}

class _PayDollarButtonState extends State<PayDollarButton> {
  @override
  void initState() {
    PurchaseController purchaseController =
        Provider.of<PurchaseController>(super.context, listen: false);
    void onSuccess() {
      FirebaseController firebaseController =
          Provider.of<FirebaseController>(super.context, listen: false);
      Function whenExpires = firebaseController.stopListening;
      firebaseController.purchase();
      Provider.of<SuccessController>(super.context, listen: false)
          .startTimer(whenExpires);
      Navigator.of(super.context).pushNamed('/success');
    }

    purchaseController.initializeOnSucces(onSuccess);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseController>(
        builder: ((_, purchaseController, __) => TextButton(
              onPressed: () {
                purchaseController.makePurchase();
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: DollarTheme.orangeText),
                  ),
                ),
                backgroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.white),
                minimumSize:
                    const MaterialStatePropertyAll<Size>(Size.fromHeight(50)),
              ),
              child: Text(
                purchaseController.buttonText(),
                style: TextStyle(
                  color: DollarTheme.orangeText,
                ),
              ),
            )));
  }
}
