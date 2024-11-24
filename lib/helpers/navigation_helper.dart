import 'package:flutter/material.dart';

class NavigatorHelper {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState getNavigator() {
    return navigatorKey.currentState!;
  }

  static navigate({required Widget destination}) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => destination),
    );
  }
}
