import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static failed({required msg}) {
    Get.snackbar("FAILED", msg,
        colorText: Colors.black87, backgroundColor: Colors.red);
  }

  static success({required msg}) {
    Get.snackbar("SUCCESSFUL", msg,
        colorText: Colors.white, backgroundColor: Colors.green);
  }
}
