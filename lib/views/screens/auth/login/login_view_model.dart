import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/preferences_helper.dart';
import 'package:mcq/repository/auth_repository.dart';
import 'package:mcq/utils/app_snackbar.dart';
import 'package:mcq/views/screens/auth/toggle/toggle_utils.dart';
import 'package:mcq/views/screens/bottom_navbar/bottom_navbar_screen.dart';

class LoginViewModel extends GetxController {
  final formKey = GlobalKey<FormState>(),
      userNameController = TextEditingController().obs,
      passwordController = TextEditingController().obs,
      authRepository = Get.put(AuthRepository()),
      userNameError = Rx<String?>(null),
      passwordError = Rx<String?>(null);

  final Function(bool) loading;
  Function(ToggleSelection val) onPressedForgetPassword;

  LoginViewModel({
    required this.loading,
    required this.onPressedForgetPassword,
  }) {
    userNameController.value.text = "Test1234@gmail.com";
    passwordController.value.text = "Test@1234";
  }

  onPressedForgetPass() {
    onPressedForgetPassword(ToggleSelection.forgetPassword);
  }

  void disposeItems() {
    userNameController.value.dispose();
    passwordController.value.dispose();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      loading(true);
      final request = {
        'username': userNameController.value.text,
        'password': passwordController.value.text,
      };
      final response = await authRepository.login(request: request);
      loading(false);
      if (response['responseCode'] == 1) {
        final token = response['data']['token'] as String;
        PreferenceHelper.saveLoggedInStatus(token);
        AppSnackBar.success(msg: "Login successful!");
        Get.off(const BottomNavbarScreen());
      } else {
        AppSnackBar.failed(msg: response['responseMessage']);
      }
    }
  }
}
