import 'package:get/get.dart';

class QuestionStatusViewModel extends GetxController {
  RxBool isListMode = false.obs;
  RxBool isUltimateMode = false.obs;
  RxBool showCheckBox = false.obs;

  onPressedListMode() {
    isListMode.value = !isListMode.value;
  }

  onChangedUltimateMode(bool value) {
    isUltimateMode.value = value;
  }
}
