import 'package:flutter/material.dart';
import 'package:mcq/views/components/bottom_sheet_content.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';
import 'package:mcq/views/screens/profile/inner_screen/mobile/update_mobile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UpdateMobileNumberScreen extends StatefulWidget {
  final UpdateMobileNumberViewModel vm;

  const UpdateMobileNumberScreen({
    super.key,
    required this.vm,
  });

  @override
  State<UpdateMobileNumberScreen> createState() => _UpdateMobileNumberScreenState();
}

class _UpdateMobileNumberScreenState extends State<UpdateMobileNumberScreen> {

  @override
  Widget build(BuildContext context) {
    return  BottomSheetContent(
      title: "Update mobile number",
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: widget.vm.pageController,
          children: [
            /// FIRST SCREEN - NEW MOBILE NUMBER
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 26),
                  const Text('Enter New Mobile Number',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: "New Mobile Number",
                    controller: widget.vm.mobileNumberController,
                  ),
                  const SizedBox(height: 26),
                  CustomButton(
                    width: 100.w,
                    title: "SEND OTP",
                    onPressed: widget.vm.sendMobileOtp,
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
                    'Enter OTP For New Mobile Number',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  CustomTextField(
                    labelText: "Enter Mobile OTP",
                    controller: widget.vm.newMobileOtpController,
                  ),
                  const SizedBox(height: 26),
                  CustomButton(
                    width: 100.w,
                    title: "OTP VERIFICATION",
                    onPressed: widget.vm.verificationNewMobileOtp,
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
                    'Enter OTP For Old Mobile Number',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  CustomTextField(
                    labelText: "Enter Mobile OTP",
                    controller: widget.vm.oldMobileOtpController,
                  ),
                  const SizedBox(height: 26),
                  CustomButton(
                    width: 100.w,
                    title: "OTP VERIFICATION",
                    onPressed: widget.vm.verificationOldMobileOtp,
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
