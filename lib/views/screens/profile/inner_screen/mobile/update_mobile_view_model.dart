import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/repository/profile_repository.dart';

class UpdateMobileNumberViewModel extends GetxController {
  final mobileNumberController = TextEditingController();
  final newMobileOtpController = TextEditingController();
  final oldMobileOtpController = TextEditingController();
  int currentPageIndex = 0;

  PageController? pageController;
  ProfileRepository? profileRepository;
  RxBool isLoading=false.obs;

  final Function(String) updatedMobileCallback;
  final String oldMobileNo;

  UpdateMobileNumberViewModel({
    required this.updatedMobileCallback,
    required this.oldMobileNo,
  }) {
    setPageController();
    profileRepository = Get.put(ProfileRepository());
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

  onPressedBackButton(){
    if(currentPageIndex>0){
      previousPage();
    }
    else{
      Get.back();
    }
  }

  void sendMobileOtp() {
    nextPage();
    // Implement your logic for sending the mobile OTP here
  }

  void verificationNewMobileOtp() {
    nextPage();
    // Implement your logic for verifying the new mobile OTP here
  }

  void verificationOldMobileOtp() {
    // Implement your logic for verifying the old mobile OTP here
  }

  void updateMobileNo() {
  }
}
