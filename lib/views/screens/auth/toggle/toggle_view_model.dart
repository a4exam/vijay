import 'package:get/get.dart';
import 'package:mcq/views/screens/auth/forget_password/forgot_password_view_model.dart';
import 'package:mcq/views/screens/auth/login/login_view_model.dart';
import 'package:mcq/views/screens/auth/resignation/resignation_view_model.dart';
import 'package:mcq/views/screens/bottom_navbar/bottom_navbar_screen.dart';
import 'components/forgot_password_done_dialog.dart';
import 'package:mcq/views/screens/auth/toggle/toggle_utils.dart';
import 'components/resignation_done_dialog.dart';

class ToggleViewModel extends GetxController {
  RxBool loading = false.obs;

  setLoading(bool val) {
    loading.value = val;
  }

  RxString topTitle = "".obs;
  RxString topSubTitle = "".obs;
  RxBool showBackButton = false.obs;
  RxString titleAtToggle = "".obs;

  onSetValue(int index) {
    final data = ToggleUtils.pageListData[index];
    topTitle.value = data.topTitle;
    topSubTitle.value = data.topSubTitle;
    showBackButton.value = data.backButton;
    titleAtToggle.value = data.titleAtToggle;
  }

  final selectedToggle = ToggleSelection.login.obs;

  setSelectedToggle(val) {
    selectedToggle.value = val;
    if (selectedToggle.value == ToggleSelection.login) {
      onSetValue(ToggleUtils.startLoginPageIndex);
    }
  }

  late LoginViewModel loginViewModel;
  late ResignationViewModel resignationViewModel;
  late ForgotPasswordViewModel forgotPasswordViewModel;

  ToggleViewModel() {
    onSetValue(ToggleUtils.startLoginPageIndex);
    loginViewModel = Get.put(
      LoginViewModel(
        loading: setLoading,
        onPressedForgetPassword: setSelectedToggle,
      ),
    );

    resignationViewModel = Get.put(
      ResignationViewModel(
        loading: setLoading,
        callBackCurrentPageIndex: onSetValue,
        onResignationDone: onResignationDone,
      ),
    );

    forgotPasswordViewModel = Get.put(
      ForgotPasswordViewModel(
        loading: setLoading,
        callBackCurrentPageIndex: onSetValue,
        onForgotPasswordDone: onForgotPasswordDone,
      ),
    );
  }

  onPressedBackButton() {
    switch (selectedToggle.value) {
      case ToggleSelection.resignation:
        resignationViewModel.previousPage();
        break;
      case ToggleSelection.forgetPassword:
        if (forgotPasswordViewModel.currentPageIndex ==
            ToggleUtils.startForgotPasswordPageIndex) {
          setSelectedToggle(ToggleSelection.login);
          return;
        }
        forgotPasswordViewModel.previousPage();
        break;
      case ToggleSelection.login:
        break;
    }
    resignationViewModel.previousPage();
  }

  onResignationDone() {
    resignationDoneDialog(onPressed: () {
      Get.back();
      Get.off(const BottomNavbarScreen());
    });
  }

  onForgotPasswordDone() {
    forgotPasswordDoneDialog(onPressed: () {
      Get.back();
      forgotPasswordViewModel.currentPageIndex =
          ToggleUtils.startForgotPasswordPageIndex;
      selectedToggle.value = ToggleSelection.login;
    });
  }
}
