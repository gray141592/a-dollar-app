import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

import 'package:a_dollar_app/components/home/index.dart';

// Auto-consume must be true on iOS.
// To try without auto-consume on another platform, change `true` to `false` here.
final bool _kAutoConsume = Platform.isIOS || true;

const List<String> _kProductIds = <String>[
  'onedollarproduct',
];

class PayDollarButton extends StatefulWidget {
  const PayDollarButton({super.key});

  @override
  State<PayDollarButton> createState() => PayDollarButtonState();
}

class PayDollarButtonState extends State<PayDollarButton> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  ProductDetails? _product;
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {});
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _product = null;
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _product = productDetailResponse.productDetails.first;
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = "Product not found";
        _isAvailable = isAvailable;
        _product = null;
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }
    setState(() {
      _isAvailable = isAvailable;
      _product = productDetailResponse.productDetails.first;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = <Widget>[];
    if (_queryProductError == null) {
      stack.add(_buildProductList());
    } else {
      stack.add(Center(
        child: Text(_queryProductError!),
      ));
    }
    if (_purchasePending) {
      stack.add(
        // TODO(goderbauer): Make this const when that's available on stable.
        // ignore: prefer_const_constructors
        Stack(
          children: const <Widget>[
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: stack,
    );
  }

  Widget _buildProductList() {
    if (_loading) {
      return const CircularProgressIndicator();
    }
    if (!_isAvailable) {
      return Container();
    }

    return ElevatedButton(
      onPressed: () {
        late PurchaseParam purchaseParam;

        if (Platform.isIOS) {
          purchaseParam = PurchaseParam(
            productDetails: _product!,
          );
        }
        _inAppPurchase.buyConsumable(
            purchaseParam: purchaseParam, autoConsume: _kAutoConsume);
      },
      child: const Text("Pay a dollar"),
    );
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    setState(() {
      _purchasePending = false;
    });
    Navigator.of(context).pushNamed('/success');
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          deliverProduct(purchaseDetails);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
