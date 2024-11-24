import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/repository/auth_repository.dart';

class UpdatePasswordViewModel extends GetxController {
  final oldPassController = TextEditingController(),
      newPassController = TextEditingController(),
      confirmPassController = TextEditingController(),
      formKey = GlobalKey<FormState>(),
      repository = Get.put(AuthRepository());
  RxBool loading = false.obs;

  setLoading(bool val) {
    loading.value = val;
  }

  onPressedChangePassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    setLoading(true);
    final request = {
      "oldPassword": oldPassController.value.text,
      "newPassword": newPassController.value.text,
    };
    var response = await repository.updatePassword(body: request);
    setLoading(false);
    final color = response['responseCode'] == 1 ? Colors.green : Colors.red;
    Get.snackbar(
      "Account",
      response['responseMessage'],
      colorText: Colors.white,
      backgroundColor: color,
    );
    if (response['responseCode'] == 1) Get.back();
  }
}
