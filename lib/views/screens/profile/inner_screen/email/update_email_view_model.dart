import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateEmailViewModel extends GetxController {
  final emailController = TextEditingController();
  final newEmailOtpController = TextEditingController();
  final oldEmailOtpController = TextEditingController();
  int currentPageIndex = 0;

  PageController? pageController;
  RxBool loading = false.obs;


  final Function(String) updatedEmailCallback;
  final String oldEmail;

  UpdateEmailViewModel({
    required this.updatedEmailCallback,
    required this.oldEmail,
  }) {
    setPageController();
  }

  setPageController(){
    pageController = PageController(initialPage: currentPageIndex);
  }

  void nextPage() {
    if (currentPageIndex < 3) {
      pageController?.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      currentPageIndex++;
    }
  }

  void previousPage() {
    if (currentPageIndex > 0) {
      pageController?.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      currentPageIndex--;
    }
  }

  void sendEmailOtp() {
    nextPage();
    // Implement your logic for sending the mobile OTP here
  }

  void verificationNewEmailOtp() {
    nextPage();
    // Implement your logic for verifying the new mobile OTP here
  }

  void verificationOldEmailOtp() {
    // Implement your logic for verifying the old mobile OTP here
  }

  onPressedBackButton(){
    if(currentPageIndex>0){
      previousPage();
    }
    else{
      Get.back();
    }
  }

  Future<void> submitButton() async {
    loading(true);
    final body = {
      'oldEmail': oldEmail,
      'newEmail': newEmailOtpController.text,
    };
    // final req = await updateEmailCallback(body);
    loading(false);
    // if(req.msg !=null){
    //   ToastHelper.showToast(req.msg!);
    // }
  }
}
