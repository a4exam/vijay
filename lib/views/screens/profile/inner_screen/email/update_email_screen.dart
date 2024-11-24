import 'package:flutter/material.dart';
import 'package:mcq/views/components/bottom_sheet_content.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';
import 'package:mcq/views/screens/profile/inner_screen/email/update_email_view_model.dart';
import 'package:sizer/sizer.dart';

class UpdateEmailScreen extends StatefulWidget {
  final UpdateEmailViewModel vm;

  const UpdateEmailScreen({super.key, required this.vm});

  @override
  State<UpdateEmailScreen> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmailScreen> {

  @override
  Widget build(BuildContext context) {
    return BottomSheetContent(
      title: "Update email",
      onPressedBackBtn: widget.vm.onPressedBackButton,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: widget.vm.pageController,
          children: [
            /// FIRST SCREEN
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 26),
                  const Text(
                    'Enter New Email',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: "New Email",
                    keyboardType: TextInputType.emailAddress,
                    controller: widget.vm.emailController,
                  ),
                  const SizedBox(height: 26),
                  CustomButton(
                    width: 100.w,
                    title: "SEND OTP",
                    onPressed: widget.vm.sendEmailOtp,
                  )
                ],
              ),
            ),

            /// SECOND SCREEN -
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 26),
                  const Text(
                    'Enter OTP For New Email',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  CustomTextField(
                    labelText: "Enter Email OTP",
                    controller: widget.vm.newEmailOtpController,
                  ),
                  const SizedBox(height: 26),
                  CustomButton(
                    width: 100.w,
                    title: "OTP VERIFICATION",
                    onPressed: widget.vm.verificationNewEmailOtp,
                  )
                ],
              ),
            ),

            /// Threed SCREEN - Repeat/Mismatch
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 26),
                  const Text(
                    'Enter OTP For Old Email',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  CustomTextField(
                    labelText: "Enter Email OTP",
                    controller: widget.vm.oldEmailOtpController,
                  ),
                  const SizedBox(height: 26),
                  CustomButton(
                    width: 100.w,
                    title: "OTP VERIFICATION",
                    onPressed: widget.vm.verificationOldEmailOtp,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
