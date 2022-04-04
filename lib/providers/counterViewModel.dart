import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class CounterViewModel extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  void inCrementCounter() {
    _counter = _counter + 1;
    notifyListeners();
  }

  CollectionReference users = FirebaseFirestore.instance.collection("users");
  addUser() {
    try {
      users.add({
        'full_name': "Imran Khan", // John Doe
        'company': 'Actic', // Stokes and Sons
        'age': 36 // 42
      });
    } catch (e) {
      print(e);
    }
  }

  void setToNull() {
    _counter = 0;
    notifyListeners();
  }

  void incrementCounterbyTow() {
    _counter = _counter - 2;
    notifyListeners();
  }
}
