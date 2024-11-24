import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/repository/auth_repository.dart';
import 'package:mcq/utils/validator.dart';
import 'package:mcq/views/screens/auth/toggle/toggle_utils.dart';

class ForgotPasswordViewModel extends GetxController {
  final Function(bool) loading;
  final Function(int) callBackCurrentPageIndex;
  final Function() onForgotPasswordDone;

  ForgotPasswordViewModel({
    required this.loading,
    required this.callBackCurrentPageIndex,
    required this.onForgotPasswordDone,
  }) {
    pageController = PageController();
  }

  final emailMobileFormKey = GlobalKey<FormState>(),
      otpFormKey = GlobalKey<FormState>(),
      passwordFormKey = GlobalKey<FormState>(),
      userNameController = TextEditingController(),
      otpController = TextEditingController(),
      receivedPasswordController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmPasswordController = TextEditingController(),
      authRepository = Get.put(AuthRepository());

  String? emailError;
  String? mobileError;
  PageController? pageController;
  int currentPageIndex = ToggleUtils.startForgotPasswordPageIndex;

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    otpController.dispose();
    passwordController.dispose();
    receivedPasswordController.dispose();
    confirmPasswordController.dispose();
    pageController?.dispose();
  }

  setPage() {
    pageController?.dispose();
    pageController = PageController(
      initialPage: currentPageIndex - ToggleUtils.startForgotPasswordPageIndex,
    );
  }

  void nextPage() {
    if (currentPageIndex <= ToggleUtils.endForgotPasswordPageIndex) {
      pageController?.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      currentPageIndex++;
      callBackCurrentPageIndex(currentPageIndex);
    }
  }

  void previousPage() {
    if (currentPageIndex > ToggleUtils.startForgotPasswordPageIndex) {
      pageController?.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      currentPageIndex--;
      callBackCurrentPageIndex(currentPageIndex);
    }
  }

  String getLabelName() {
    if (Validator.isUserNameGmail(userNameController.text)) {
      return "Enter Email OTP";
    } else {
      return "Enter Mobile OTP";
    }
  }

  String? validateConfirmPassword(String? confirmPassword) {
    return Validator.validateConfirmPassword(
      passwordController.value.text,
      confirmPassword,
    );
  }

  void sendPasswordOnEmail() async {
    if (!emailMobileFormKey.currentState!.validate()) {
      return;
    }
    loading(true);
    final request = {"username": userNameController.value.text};
    var response = await authRepository.forgotPassword(body: request);
    loading(false);
    final color = response['responseCode'] == 1 ? Colors.green : Colors.red;
    Get.snackbar(
      "Account",
      response['responseMessage'],
      colorText: Colors.white,
      backgroundColor: color,
    );
    if (response['responseCode'] == 1) nextPage();
  }

  changePassword() async {
    if (!passwordFormKey.currentState!.validate()) return;
    loading(true);
    final request = {
      "oldPassword": receivedPasswordController.value.text,
      "newPassword": passwordController.value.text,
    };
    var response = await authRepository.updatePassword(body: request);
    loading(false);
    final color = response['responseCode'] == 1 ? Colors.green : Colors.red;
    Get.snackbar(
      "Account",
      response['responseMessage'],
      colorText: Colors.white,
      backgroundColor: color,
    );
    if (response['responseCode'] == 1) onForgotPasswordDone();
  }
}
