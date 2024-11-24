import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/components/drop_down/drop_down.dart';
import 'package:mcq/views/components/drop_down/drop_down_utils.dart';
import 'package:mcq/views/components/drop_down/dropdown_view_model.dart';
import 'package:mcq/views/components/otp_text_field.dart';
import 'package:mcq/views/screens/auth/resignation/resignation_utils.dart';
import 'package:sizer/sizer.dart';
import 'package:mcq/utils/validator.dart';
import 'package:mcq/views/screens/auth/resignation/resignation_view_model.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';
import 'package:mcq/views/components/custom_text_field_for_password.dart';
import 'package:intl/intl.dart';
import 'components/user_type_view.dart';

class ResignationScreen extends StatefulWidget {
  final ResignationViewModel vm;

  const ResignationScreen({
    super.key,
    required this.vm,
  });

  @override
  State<ResignationScreen> createState() => _ResignationScreenState();
}

class _ResignationScreenState extends State<ResignationScreen> {
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
    return Scaffold(
      body: PageView(
        controller: widget.vm.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          /// First Screen - user type student or teacher
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Obx(
                  () => UserTypeView(
                    image: "assets/images/student.png",
                    title: "Student",
                    value: ResignationUtils.studentType,
                    selected: widget.vm.userType.value,
                    onPressed: widget.vm.setUserType,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => UserTypeView(
                    image: "assets/images/teacher.png",
                    title: "Teacher",
                    value: ResignationUtils.teacherType,
                    selected: widget.vm.userType.value,
                    onPressed: widget.vm.setUserType,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: widget.vm.termsAndConditions.value,
                        activeColor: AppColors.primaryColor,
                        onChanged: widget.vm.setTermsAndConditions,
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "I agree with the",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextSpan(
                              text: ' terms and conditions ',
                              style: TextStyle(color: AppColors.primaryColor),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            const TextSpan(
                              text:
                                  "and also the protection of my personal data on this application ",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  title: "Continue",
                  width: 100.h,
                  onPressed: widget.vm.onPressedContinueBtn,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),

          /// SECOND SCREEN- sent otp
          SingleChildScrollView(
            child: Form(
              key: widget.vm.emailMobileFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  Obx(
                    () => CustomTextField(
                      labelText: "Email",
                      controller: widget.vm.emailController.value,
                      suffixIcon: Icons.email,
                      validator: Validator.validateEmail,
                      errorText: widget.vm.emailError.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => CustomTextField(
                      labelText: "Mobile Number",
                      suffixIcon: Icons.call,
                      controller: widget.vm.mobileNumberController.value,
                      validator: Validator.validateMobileNumber,
                      errorText: widget.vm.mobileError.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: "SEND OTP",
                    width: 100.h,
                    onPressed: widget.vm.onPressedSendOTPBtn,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          /// THIRD SCREEN- enter otp
          SingleChildScrollView(
            child: Form(
              key: widget.vm.otpFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// ENTER EMAIL OTP
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Enter Email OTP"),
                      const SizedBox(width: 10),
                      Obx(
                        () => Text(
                          widget.vm.emailController.value.text,
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  OTPTextField(
                    controller: widget.vm.emailOTPController,
                    otpLength: 4,
                  ),

                  /// SUBMIT BUTTON
                  const SizedBox(height: 42),
                  CustomButton(
                    title: "OTP VERIFICATION",
                    width: 100.h,
                    onPressed: widget.vm.onPressedOtpVerificationBtn,
                  ),
                ],
              ),
            ),
          ),

          /// FOURTH SCREEN
          SingleChildScrollView(
            child: Form(
              key: widget.vm.personalInfoFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 5),
                  CustomTextField(
                    labelText: "Name",
                    controller: widget.vm.nameController,
                    suffixIcon: Icons.person,
                    validator: Validator.validateName,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: widget.vm.dobController,
                    readOnly: true,
                    suffixIcon: Icons.date_range,
                    validator: Validator.validateDateOfBirth,
                    labelText: "Date of birth (dd/mm/yyyy)",
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          widget.vm.dobController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  DropDown(
                    vm: DropdownViewModel(
                      suffixIcon: Icons.group,
                      dataList: DropDownUtils.genderItems,
                      controller: widget.vm.genderController,
                      title: "Gender",
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropDown(
                    vm: DropdownViewModel(
                      suffixIcon: Icons.menu_book_outlined,
                      selectedLimit: widget.vm.examPreparationList.length,
                      dataList: widget.vm.examPreparationList,
                      controller: widget.vm.examPreparationController,
                      title: "Exam Preparation",
                      onChanged: (_, __,newSelectedExamIds) {
                        widget.vm.setSelectedExamIds(newSelectedExamIds);
                      },
                      isShowImage: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    title: "Submit",
                    width: 100.h,
                    onPressed: widget.vm.personalInformationSubmit,
                  ),
                ],
              ),
            ),
          ),

          /// FevTH SCREEN
          SingleChildScrollView(
            child: Form(
              key: widget.vm.passwordFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 5),
                  CustomTextFieldForPassword(
                    labelText: "Password",
                    controller: widget.vm.passwordController,
                    validator: Validator.validatePassword,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFieldForPassword(
                    labelText: "Confirm Password",
                    controller: widget.vm.confirmPasswordController,
                    validator: (confirmPassword) {
                      return Validator.validateConfirmPassword(
                        widget.vm.passwordController.text,
                        confirmPassword,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    title: "SIGN UP",
                    width: MediaQuery.of(context).size.width,
                    onPressed: widget.vm.signUpButton,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
