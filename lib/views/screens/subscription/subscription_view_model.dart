import 'package:flutter/material.dart';

class SubscriptionViewModel with ChangeNotifier {
  int selectedSubscription = 0;

  void selectSubscription(int index) {
    selectedSubscription = index;
    notifyListeners();
  }

  void payNow() {}
}
