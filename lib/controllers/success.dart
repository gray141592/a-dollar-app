import 'dart:async';

import 'package:flutter/material.dart';

class SuccessController extends ChangeNotifier {
  int countdown = 0;
  bool hasAccess = false;

  SuccessController();

  void startTimer(Function whenExpires) {
    countdown = 60;
    hasAccess = true;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (countdown == 0) {
          timer.cancel();
          hasAccess = false;
          whenExpires();
          notifyListeners();
        } else {
          countdown--;
          notifyListeners();
        }
      },
    );
  }

  String timerText() {
    if (!hasAccess) {
      return "";
    }
    if (countdown <= 0) {
      return "Time is up";
    }
    if (countdown < 10) {
      return "00:0$countdown seconds left";
    }
    if (countdown == 60) {
      return "01:00 seconds left";
    }
    return "00:$countdown seconds left";
  }
}
