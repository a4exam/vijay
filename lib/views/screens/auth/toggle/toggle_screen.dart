import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/screens/auth/forget_password/forgot_password_screen.dart';
import 'package:mcq/views/screens/auth/login/login_screen.dart';
import 'package:mcq/views/screens/auth/resignation/resignation_screen.dart';
import 'package:mcq/views/screens/auth/toggle/toggle_view_model.dart';
import 'package:mcq/views/components/loading.dart';
import 'components/text_view.dart';
import 'components/toggle.dart';
import 'toggle_utils.dart';

class ToggleScreen extends StatefulWidget {
  const ToggleScreen({super.key});

  @override
  State<ToggleScreen> createState() => _ToggleScreenState();
}

class _ToggleScreenState extends State<ToggleScreen> {
  final vm = Get.put(ToggleViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height * .30,
            color: AppColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 116, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Visibility(
                          visible: vm.showBackButton.value,
                          child: Container(
                            height: Get.height * .1,
                            width: Get.width * .1,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: FloatingActionButton(
                              onPressed: vm.onPressedBackButton,
                              backgroundColor: AppColors.primaryColor,
                              child: const Icon(Icons.arrow_back_rounded),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                vm.topTitle.value,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height * .01),
                            Obx(
                              () => Text(
                                vm.topSubTitle.value,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Get.height * .25),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Column(
              children: [
                Obx(
                  () => vm.titleAtToggle.value.isEmpty
                      ? Toggle(
                          onChange: vm.setSelectedToggle,
                          selectedToggle: vm.selectedToggle.value,
                        )
                      : TextView(title: vm.titleAtToggle.value),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(() {
                      switch (vm.selectedToggle.value) {
                        case ToggleSelection.login:
                          return LoginScreen(vm: vm.loginViewModel);
                        case ToggleSelection.resignation:
                          return ResignationScreen(vm: vm.resignationViewModel);
                        case ToggleSelection.forgetPassword:
                          return ForgotPasswordScreen(
                            vm: vm.forgotPasswordViewModel,
                          );
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => LoadingView(loading: vm.loading.value)),
        ],
      ),
    );
  }
}
