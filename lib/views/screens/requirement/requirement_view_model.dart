import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/models/comman/user_profile_data.dart';
import 'package:mcq/repository/home_repository.dart';

class RequirementViewModel extends GetxController {
  late HomeRepository homeRepository;
  final improveController = TextEditingController();
  final aboutProblemController = TextEditingController();
  RxString selectedRating = "".obs;

  setSelectedRating(val) {
    selectedRating.value = val;
  }

  RxBool loading = false.obs;

  final UserProfileData userData;

  RequirementViewModel({required this.userData}) {
    homeRepository = HomeRepository();
  }

  Future<void> onPressedSubmitBtn() async {
    loading.value = true;
    final body = {
      'name': userData.fullName,
      'email': userData.email,
      'mobileNo': userData.mobileNo,
      'improve': improveController.text,
      'rateExperience': selectedRating.value,
      'aboutProblem': aboutProblemController.text
    };

    final req = await homeRepository.sendRequirement(body);

    if (req.msgtype == "success") {
      improveController.text = "";
      aboutProblemController.text = "";
      selectedRating.value = "";
      Get.snackbar("Success", req.msg!,
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar("Failed", req.msg!,
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    loading.value = false;
  }
}
