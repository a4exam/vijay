import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/utils/validator.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';
import 'package:mcq/views/screens/profile/inner_screen/password/UpdatePasswordViewModel.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final vm = Get.put(UpdatePasswordViewModel());

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_outlined),
              ),
              const Text(
                'Update Password',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Form(
              key: vm.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                      labelText: "Old Password",
                      controller: vm.oldPassController,
                      validator: Validator.validatePassword),
                  const SizedBox(height: 20),
                  CustomTextField(
                      labelText: "New Password",
                      controller: vm.newPassController,
                      validator: Validator.validatePassword),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: "Confirm Password",
                    controller: vm.confirmPassController,
                    validator: (confirmPassword) {
                      return Validator.validateConfirmPassword(
                          vm.newPassController.text, confirmPassword);
                    },
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => CustomButton(
                      title:
                          vm.loading.value ? "Loading..." : "Change Password",
                      width: Get.width,
                      onPressed: vm.onPressedChangePassword,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
