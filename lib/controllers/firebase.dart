import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:a_dollar_app/firebase_options.dart';

class FirebaseController extends ChangeNotifier {
  bool _initialized = false;
  int? count;
  StreamSubscription<DatabaseEvent>? _updateStream;
  late FirebaseDatabase database;
  FirebaseController() {
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: 'a_dollar_app',
    );
    database = FirebaseDatabase.instance;
    _initialized = true;
    notifyListeners();
  }

  String countFormatted() {
    if (!_initialized || count == null) {
      return "0";
    }
    if (count == 1) {
      return "?";
    }
    return count.toString();
  }

  void purchase() {
    final DatabaseReference docRef = database.ref("purchases");
    docRef.child('count').set(ServerValue.increment(1));
    startListening();
  }

  void startListening() {
    final DatabaseReference docRef = database.ref("purchases/count");
    _updateStream = docRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateCount(data);
    });
  }

  void updateCount(data) {
    count = data;
    notifyListeners();
  }

  void stopListening() {
    if (_updateStream != null) {
      _updateStream!.cancel();
    }
  }
}
