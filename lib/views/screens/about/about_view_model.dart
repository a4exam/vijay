import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutViewModel extends GetxController {
  RxBool loading = false.obs;

  onPressed(String? url) async {
    loading.value = true;
    if (url == null) {
      Get.snackbar(
        "Coming soon",
        "Please what for next update",
        colorText: Colors.black,
      );
    }
    var uri = Uri.parse(url!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
    loading.value = false;
  }
}
