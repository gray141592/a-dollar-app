import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class PurchaseController extends ChangeNotifier {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  ProductDetails? _product;
  final bool _kAutoConsume = Platform.isIOS || true;
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  final List<String> _kProductIds = <String>[
    'onedollarproduct',
  ];
  String? errorMessage;
  late Function onSuccess;

  PurchaseController();

  Future<void> initialize() async {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {});
    await initStoreInfo();
    await initializeProduct();
    notifyListeners();
  }

  void initializeOnSucces(Function onSuccess) {
    this.onSuccess = onSuccess;
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    _isAvailable = isAvailable;
    if (!isAvailable) {
      errorMessage = "Purchase not available";
      _loading = false;
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
  }

  String buttonText() {
    if (_isAvailable && _product != null) {
      return "Pay now";
    }
    if (!_isAvailable && errorMessage != null) {
      return errorMessage!;
    }
    if (!_isAvailable) {
      return "Store not available";
    }
    return "Product not available";
  }

  Future<void> initializeProduct() async {
    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      errorMessage = productDetailResponse.error!.message;
      _product = productDetailResponse.productDetails.first;
      _purchasePending = false;
      _loading = false;
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      errorMessage = "Product not found";
      _purchasePending = false;
      _loading = false;
      return;
    }
    _product = productDetailResponse.productDetails.first;
    _purchasePending = false;
    _loading = false;
  }

  void handleError(IAPError error) {}

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _loading = true;
      } else {
        _loading = false;
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          onSuccess();
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> makePurchase() async {
    if (_isAvailable && _product != null) {
      _inAppPurchase.buyConsumable(
          purchaseParam: PurchaseParam(
            productDetails: _product!,
          ),
          autoConsume: _kAutoConsume);
    }
  }

  void onDispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
  }
}

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
