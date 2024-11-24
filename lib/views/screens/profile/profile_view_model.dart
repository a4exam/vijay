import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/preferences_helper.dart';
import 'package:mcq/repository/profile_repository.dart';
import 'package:mcq/view_models/UserDataViewModel.dart';
import 'package:mcq/views/components/drop_down/drop_down_utils.dart';
import 'package:mcq/views/screens/profile/inner_screen/address/update_address_view_model.dart';
import 'package:mcq/views/screens/profile/inner_screen/email/update_email_view_model.dart';
import 'package:mcq/views/screens/profile/inner_screen/exam_preparation/ExamPreparationScreen.dart';
import 'package:mcq/views/screens/profile/inner_screen/exam_preparation/ExamPreparationViewModel.dart';
import 'package:mcq/views/screens/profile/inner_screen/mobile/update_mobile_view_model.dart';
import 'package:mcq/views/screens/profile/inner_screen/address/update_address_screen.dart';
import 'package:mcq/views/screens/profile/inner_screen/email/update_email_screen.dart';
import 'package:mcq/views/screens/profile/inner_screen/mobile/update_mobile_number_screen.dart';
import 'package:mcq/views/screens/profile/inner_screen/password/update_password_view.dart';
import 'package:sizer/sizer.dart';

class ProfileViewModel extends GetxController {
  final formKey = GlobalKey<FormState>(),
      nameController = TextEditingController(),
      dobController = TextEditingController(),
      genderController = TextEditingController(),
      emailController = TextEditingController(),
      categoryController = TextEditingController(),
      mobileNumberController = TextEditingController(),
      examPreparationController = TextEditingController(),
      passwordController = TextEditingController(),
      addressController = TextEditingController(),
      educationController = TextEditingController(),
      profileRepository = Get.put(ProfileRepository());
  late ExamPreparationViewModel examVm;
  late UserdataViewModel userdataVm;
  late String country,
      state,
      district,
      town,
      pinCode,
      token,
      ganderName,
      ganderId,
      examPreparationName = "",
      examPreparationId = "";
  RxBool loading = false.obs;

  setLoading(val) {
    loading.value = val;
  }

  ProfileViewModel() {
    initData();
  }

  initData() async {
    userdataVm = Get.put(UserdataViewModel());
    final uData = userdataVm.userData.value;
    nameController.text = uData?.fullName ?? "";
    emailController.text = uData?.email ?? "";
    mobileNumberController.text = uData?.mobileNo ?? "";
    dobController.text = uData?.dateOfBirth ?? "";
    genderController.text = uData?.gander ?? "";
    categoryController.text = uData?.category ?? "";
    categoryController.text = uData?.category ?? "";
    educationController.text = uData?.education ?? "";
    examPreparationController.text = uData?.examNameId ?? "";
    country = uData?.country ?? "";
    state = uData?.state ?? "";
    district = uData?.district ?? "";
    town = uData?.town ?? "";
    pinCode = uData?.pincode ?? "";
    ganderName = uData?.gander ?? "";
    ganderId = DropDownUtils.getGanderIdByName(ganderName);
    token = await PreferenceHelper.getToken();
    examVm = Get.put(ExamPreparationViewModel(
        controller: examPreparationController,
        selectedId: uData?.examNameId ?? "",
        selectedName: uData?.examNameId ?? ""));
    //examVm.selectedId = userData.examNameId ?? "";
    setAddressController();
  }

  setAddressController() {
    final tempTown = town.isEmpty ? town : "$town, ";
    final tempDistrict = district.isEmpty ? district : "$district, ";
    final tempPinCode = pinCode.isEmpty ? pinCode : "($pinCode), ";
    final tempState = state.isEmpty ? state : "$state, ";
    final tempCountry = country.isEmpty ? country : "$country, ";
    String tempAddress =
        tempTown + tempDistrict + tempPinCode + tempState + tempCountry;
    if (tempAddress.isNotEmpty) {
      tempAddress = tempAddress.substring(0, tempAddress.length - 2);
    }
    addressController.text = tempAddress;
  }

  onChangedGander(List<DropdownListItem> list, String titles, String ids) {
    ganderName = titles;
    ganderId = ids;
  }

  onChangedExam(List<DropdownListItem> list, String titles, String ids) {
    examPreparationName = titles;
    examPreparationId = ids;
    examPreparationController.text = ids;
  }

  void openEmailDialog(BuildContext context) {
    final vm = Get.put(
      UpdateEmailViewModel(
        oldEmail: emailController.text,
        updatedEmailCallback: (newEmail) {
          emailController.text = newEmail;
        },
      ),
    );
    vm.setPageController();
    Get.bottomSheet(
      UpdateEmailScreen(vm: vm),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void openMobileNumberDialog(BuildContext context) {
    final vm = Get.put(
      UpdateMobileNumberViewModel(
        oldMobileNo: mobileNumberController.text,
        updatedMobileCallback: (newMobile) {
          mobileNumberController.text = newMobile;
        },
      ),
    );
    vm.setPageController();
    Get.bottomSheet(
      UpdateMobileNumberScreen(vm: vm),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void openChangePasswordDialog(BuildContext context) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SizedBox(height: 80.h, child: const UpdatePassword());
        });
  }

  void openAddressDialog() {
    final vm = UpdateAddressViewModel(
      country: country,
      state: state,
      district: district,
      town: town,
      pinCode: pinCode,
      onPressedSubmitButton: (
        String newCountry,
        String newState,
        String newDistrict,
        String newTown,
        String newPinCode,
      ) {
        country = newCountry;
        state = newState;
        district = newDistrict;
        town = newTown;
        pinCode = newPinCode;
        setAddressController();
      },
    );
    Get.bottomSheet(
      UpdateAddressScreen(vm: vm),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  gotoExamPreparationScreen() {
    //final vm = Get.put(ExamPreparationViewModel(onSubmit: (DropdownListItem selectedExam) {}));
    Get.to(
      ExamPreparationScreen(vm: examVm),
      transition: Transition.rightToLeft,
    );
  }

  onChangedProfile(File file) async {
    setLoading(true);
    final response =
        await profileRepository.changeProfile(file: file, token: token);
    setLoading(false);
    MaterialColor color;
    String msg;
    if (response["responseCode"].toString() == "1") {
      color = Colors.green;
      msg = "Updated Successfully";
      userdataVm.getUserdata();
    } else {
      color = Colors.red;
      msg = "Doesn't Updated Successfully";
    }
    Get.snackbar(
      "Profile Image",
      msg,
      colorText: Colors.white,
      backgroundColor: color,
    );
  }

  Future<void> submitProfile() async {
    if (!formKey.currentState!.validate()) return;
    setLoading(true);
    final body = {
      "id": userdataVm.userData.value?.id.toString(),
      "fullName": nameController.text,
      "email": userdataVm.userData.value?.email,
      "dateOfBirth": dobController.text.toString(),
      "mobileNo": userdataVm.userData.value?.mobileNo.toString(),
      "gander": genderController.text,
      "education": educationController.text,
      "category": categoryController.text,
      "country": country,
      "state": state,
      "district": district,
      "town": town,
      "pincode": pinCode.toString(),
      "exam_name_id": examVm.selectedId.toString()
    };
    final response =
        await profileRepository.editProfile(token: token, body: body);
    setLoading(false);
    MaterialColor backgroundColor;
    String msg;
    if (response["responseCode"].toString() == "200") {
      backgroundColor = Colors.green;
      msg = "Updated Successfully";
      userdataVm.getUserdata();
    } else {
      backgroundColor = Colors.red;
      msg = "Doesn't Updated Successfully";
    }
    Get.snackbar(
      "Profile Image",
      msg,
      colorText: Colors.white,
      backgroundColor: backgroundColor,
    );
  }
}
