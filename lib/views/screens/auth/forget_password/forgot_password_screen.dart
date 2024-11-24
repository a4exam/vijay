import 'package:flutter/material.dart';
import 'package:mcq/utils/validator.dart';
import 'package:mcq/views/screens/auth/forget_password/forgot_password_view_model.dart';
import 'package:mcq/views/components//custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';
import 'package:mcq/views/components/custom_text_field_for_password.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final ForgotPasswordViewModel vm;

  const ForgotPasswordScreen({
    super.key,
    required this.vm,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    widget.vm.setPage();
    Future.delayed(const Duration(microseconds: 100), () {
      widget.vm.callBackCurrentPageIndex(widget.vm.currentPageIndex);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.vm.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [

        /// FIRST SCREEN - USER NAME
        SingleChildScrollView(
          child: Form(
            key: widget.vm.emailMobileFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [

                /// USER NAME
                const SizedBox(height: 5),
                CustomTextField(
                  labelText: "User Name",
                  hintText: "Enter Email or Mobile Number",
                  keyboardType: TextInputType.emailAddress,
                  controller: widget.vm.userNameController,
                  suffixIcon: Icons.person,
                  validator: Validator.validateUserName,
                ),

                // SEND OTP BUTTON
                const SizedBox(height: 20),
                CustomButton(
                  title: "SEND PASSWORD",
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  onPressed: widget.vm.sendPasswordOnEmail,
                ),
              ],
            ),
          ),
        ),

        /// SECOND SCREEN - ENTER OTP
        // SingleChildScrollView(
        //   child: Form(
        //     key: widget.vm.otpFormKey,
        //     autovalidateMode: AutovalidateMode.onUserInteraction,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: [
        //         // ENTER OTP
        //         const SizedBox(height: 20),
        //         Row(
        //           children: [
        //             const Text("Enter OTP"),
        //             const SizedBox(width: 10),
        //             Text(
        //               widget.vm.userNameController.text,
        //               style: TextStyle(color: AppColors.primaryColor),
        //             )
        //           ],
        //         ),
        //         const SizedBox(height: 10),
        //         OTPTextField(controller: widget.vm.otpController),
        //
        //         /// OTP VERIFICATION BUTTON
        //         const SizedBox(height: 16),
        //         CustomButton(
        //           title: "OTP VERIFICATION",
        //           width: MediaQuery.of(context).size.width,
        //           onPressed: widget.vm.otpVerification,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        /// SECOND SCREEN- NEW PASSWORD, OLD PASSWORD
        SingleChildScrollView(
          child: Form(
            key: widget.vm.passwordFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // NEW PASSWORD
                const SizedBox(height: 20),
                CustomTextFieldForPassword(
                  labelText: "Enter Received Password",
                  controller: widget.vm.passwordController,
                  validator: Validator.validatePassword,
                ),

                // NEW PASSWORD
                const SizedBox(height: 20),
                CustomTextFieldForPassword(
                  labelText: "Enter New Password",
                  controller: widget.vm.passwordController,
                  validator: Validator.validatePassword,
                ),

                // CONFIRM PASSWORD
                const SizedBox(height: 20),
                CustomTextFieldForPassword(
                  labelText: "Enter Confirm Password",
                  controller: widget.vm.confirmPasswordController,
                  validator: widget.vm.validateConfirmPassword,
                ),

                // CREATE PASSWORD BUTTON
                const SizedBox(height: 20),
                CustomButton(
                  title: "ChANGE PASSWORD",
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  onPressed: widget.vm.changePassword,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
