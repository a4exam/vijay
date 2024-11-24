

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/utils/validator.dart';
import 'package:mcq/views/components/drop_down/drop_down.dart';
import 'package:mcq/views/components/drop_down/drop_down_utils.dart';
import 'package:mcq/views/components/drop_down/dropdown_view_model.dart';
import 'package:mcq/views/screens/profile/profile_view_model.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';
import 'package:mcq/views/components/loading_overlay.dart';
import 'package:sizer/sizer.dart';
import 'component/profile_picture_view.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final vm = ProfileViewModel();
  @override
  Widget build(BuildContext context) {
    return LoadingOverView(
      loading: vm.loading,
      child: Scaffold(
        appBar: AppBar(title: const Text("Profile")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: vm.formKey,
                  child: Column(
                    children: [
                      /// PROFILE PICTURE
                      const SizedBox(height: 16),
                      ProfilePicture(
                        imageUrl: vm.userdataVm.userData.value!.images!,
                        onChanged: vm.onChangedProfile,
                      ),

                      /// NAME
                      const SizedBox(height: 16),
                      CustomTextField(
                        labelText: "Name",
                        controller: vm.nameController,
                        validator: Validator.validateName,
                        suffixIcon: Icons.person,
                      ),

                      /// EMAIL
                      const SizedBox(height: 20),
                      CustomTextField(
                        labelText: "Email",
                        controller: vm.emailController,
                        suffixIcon: Icons.email,
                        readOnly: true,
                        enabled: false,
                        onTap: () {
                          vm.openEmailDialog(context);
                        },
                      ),

                      /// MOBILE NUMBER
                      const SizedBox(height: 20),
                      CustomTextField(
                        labelText: "Mobile Number",
                        suffixIcon: Icons.call,
                        controller: vm.mobileNumberController,
                        readOnly: true,
                        enabled: false,
                        onTap: () {
                          vm.openMobileNumberDialog(context);
                        },
                      ),

                      /// DOB
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: vm.dobController,
                        readOnly: true,
                        suffixIcon: Icons.date_range,
                        labelText: "Date of birth (dd/mm/yyyy)",
                        validator: Validator.validateDateOfBirth,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MMM-yyyy').format(pickedDate);
                            vm.dobController.text = formattedDate;
                          }
                        },
                      ),

                      /// GENDER
                      const SizedBox(height: 20),
                      DropDown(
                        vm: DropdownViewModel(
                          suffixIcon: Icons.group,
                          dataList: DropDownUtils.genderItems,
                          controller: vm.genderController,
                          title: "Gender",
                          selectedId: vm.ganderId,
                          onChanged: vm.onChangedGander,
                        ),
                      ),

                      /// CATEGORY
                      const SizedBox(height: 20),
                      DropDown(
                        vm: DropdownViewModel(
                          suffixIcon: Icons.category,
                          dataList: DropDownUtils.categoryItems,
                          controller: vm.categoryController,
                          title: "Category",
                        ),
                      ),

                      /// ADDRESS
                      const SizedBox(height: 20),
                      CustomTextField(
                        labelText: "Address",
                        suffixIcon: Icons.location_on,
                        controller: vm.addressController!,
                        readOnly: true,
                        onTap: vm.openAddressDialog,
                      ),

                      /// EDUCATION
                      const SizedBox(height: 20),
                      DropDown(
                        vm: DropdownViewModel(
                          suffixIcon: Icons.cast_for_education,
                          selectedLimit: DropDownUtils.educationItems.length,
                          dataList: DropDownUtils.educationItems,
                          controller: vm.educationController,
                          title: "Education",
                        ),
                      ),

                      /// EXAM PREPARATION
                      const SizedBox(height: 20),
                      CustomTextField(
                        readOnly: true,
                        labelText: "Exam Preparation",
                        controller: vm.examPreparationController,
                        suffixIcon: Icons.menu_book_outlined,
                        onTap: () {
                          vm.gotoExamPreparationScreen();
                        },
                      ),

                      /// SUBMIT BUTTON
                      const SizedBox(height: 32),
                      CustomButton(
                        title: "Submit",
                        width: Get.width,
                        onPressed: vm.submitProfile,
                      ),
                    ],
                  ),
                ),
              ),

              /// CHANGE PASSWORD
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 100.w,
                  height: 7.h,
                  color: Colors.black12,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "I want to ",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Change Password',
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.red,
                                fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                vm.openChangePasswordDialog(context);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
