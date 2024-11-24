import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/preferences_helper.dart';
import 'package:mcq/repository/auth_repository.dart';
import 'package:mcq/views/components/drop_down/drop_down_utils.dart';
import 'package:mcq/views/screens/auth/toggle/toggle_utils.dart';
import 'resignation_utils.dart';

class ResignationViewModel extends GetxController {
  final Function(bool) loading;
  final Function(int) callBackCurrentPageIndex;
  final Function() onResignationDone;

  ResignationViewModel({
    required this.loading,
    required this.callBackCurrentPageIndex,
    required this.onResignationDone,
  }) {
    pageController = PageController(initialPage: currentPageIndex);

    emailController.value.addListener(() {
      if (emailError.value != null) {
        emailError.value = null;
      }
    });

    mobileNumberController.value.addListener(() {
      if (mobileError.value != null) {
        mobileError.value = null;
      }
    });

    getExamPreparation();
  }

  final emailMobileFormKey = GlobalKey<FormState>(),
      otpFormKey = GlobalKey<FormState>(),
      personalInfoFormKey = GlobalKey<FormState>(),
      passwordFormKey = GlobalKey<FormState>(),
      nameController = TextEditingController(),
      dobController = TextEditingController(),
      genderController = TextEditingController(),
      emailController = TextEditingController(text: "Test@gmail.com").obs,
      mobileNumberController = TextEditingController(text: "9999999999").obs,
      examPreparationController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmPasswordController = TextEditingController(),
      emailOTPController = TextEditingController(),
      mobileOTPController = TextEditingController(),
      userType = ResignationUtils.studentType.obs,
      emailError = Rx<String?>(null),
      mobileError = Rx<String?>(null),
      termsAndConditions = false.obs,
      authRepository = Get.put(AuthRepository());

  PageController? pageController;
  int currentPageIndex = ToggleUtils.startResignationPageIndex;
  String receivedOtp = "";
  List<DropdownListItem> examPreparationList = [];
  String selectedExamIds = "";

  setSelectedExamIds(String newSelectedExamIds) {
    selectedExamIds = newSelectedExamIds;
  }

  setUserType(int val) {
    userType.value = val;
  }

  setTermsAndConditions(bool? val) {
    if (val != null) {
      termsAndConditions.value = val;
    }
  }

  ///  PAGE CONTROLLER
  setPage() {
    pageController?.dispose();
    pageController = PageController(initialPage: currentPageIndex);
  }

  void nextPage() {
    if (currentPageIndex < 4) {
      pageController?.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      currentPageIndex++;
      getExamPreparation();
      callBackCurrentPageIndex(currentPageIndex);
    }
  }

  void previousPage() {
    if (currentPageIndex > 0) {
      pageController?.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      currentPageIndex--;
      callBackCurrentPageIndex(currentPageIndex);
    }
  }

  getExamPreparation() async {
    if (examPreparationList.isNotEmpty) return;
    examPreparationList = await authRepository.getExamPreparation();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dobController.dispose();
    genderController.dispose();
    emailController.value.dispose();
    mobileNumberController.value.dispose();
    examPreparationController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailOTPController.dispose();
    mobileOTPController.dispose();
    pageController?.dispose();
  }

  /// ON PRESSED BUTTON EVENT

  void onPressedContinueBtn() {
    if (!termsAndConditions.value) {
      Get.snackbar("TERMS AND CONDITIONS", "Please Select Terms & Conditions",
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }
    nextPage();
  }

  void onPressedSendOTPBtn() async {
    if (!emailMobileFormKey.currentState!.validate()) return;
    loading(true);
    final otpBody = {
      'email': emailController.value.text,
      'mobileNo': mobileNumberController.value.text,
    };
    final response = await authRepository.sendOtp(body: otpBody);
    loading(false);
    final color = response['responseCode'] == 1 ? Colors.green : Colors.red;
    final msg = response['responseMessage'];
    Get.snackbar(
      "OTP",
      msg,
      colorText: Colors.white,
      backgroundColor: color,
    );
    if (response['responseCode'] == 1) {
      receivedOtp = response['data']['otp'];
      nextPage();
    } else if (response['responseMessage'] ==
        "User Already exists with email") {
      emailError.value = msg;
    }
   // nextPage();
  }

  void onPressedOtpVerificationBtn() async {
    if (!otpFormKey.currentState!.validate()) return;
    loading(true);
    final otpVerBody = {
      'email': emailController.value.text,
      'mobileNo': mobileNumberController.value.text,
      'otp': receivedOtp,
      'newotp': emailOTPController.value.text,
    };
    final response = await authRepository.otpVerification(body: otpVerBody);
    loading(false);
    final color = response['responseCode'] == 1 ? Colors.green : Colors.red;
    Get.snackbar(
      "OTP",
      response['responseMessage'],
      colorText: Colors.white,
      backgroundColor: color,
    );
    if (response['responseCode'] == 1) nextPage();
    //nextPage();
  }

  void personalInformationSubmit() async {
    if (personalInfoFormKey.currentState!.validate()) {
      loading(true);
      await Future.delayed(const Duration(seconds: 2));
      loading(false);
      nextPage();
    }
  }

  void signUpButton() async {
    if (passwordFormKey.currentState!.validate()) {
      loading(true);
      final request = {
        'fullName': nameController.text,
        'email': emailController.value.text,
        'mobileNo': mobileNumberController.value.text,
        'dateOfBirth': dobController.text,
        'gander': genderController.text,
        'exam_board_id': selectedExamIds,
        'password': passwordController.text,
        'type': userType.value.toString(),
      };
      var response = await authRepository.signUp(body: request);
      loading(false);
      final color = response['responseCode'] == 1 ? Colors.green : Colors.red;
      Get.snackbar(
        "Account",
        response['responseMessage'],
        colorText: Colors.white,
        backgroundColor: color,
      );
      if (response['responseCode'] == 1) login();
    }
  }

  void login() async {
    loading(true);
    final request = {
      'username': emailController.value.text,
      'password': passwordController.value.text,
    };
    var response = await authRepository.login(request: request);
    loading(false);
    if (response['responseCode'] == 1) {
      final token = response['data']['token'] as String;
      PreferenceHelper.saveLoggedInStatus(token);
      onResignationDone();
    }
  }
}
