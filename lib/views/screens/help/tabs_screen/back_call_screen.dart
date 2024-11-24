import 'package:flutter/material.dart';
import 'package:mcq/views/screens/help/help_view_model.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';
import 'package:mcq/views/components/custom_text_field_with_image.dart';
import 'package:mcq/views/components/dropdown/custom_dropdown.dart';
import 'package:mcq/utils/dropdown_data.dart';

class BackCallScreen extends StatefulWidget {
  final HelpViewModel vm;

  const BackCallScreen({super.key, required this.vm});

  static const textStyle = TextStyle(
      color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w300);

  @override
  State<BackCallScreen> createState() => _BackCallScreenState();
}

class _BackCallScreenState extends State<BackCallScreen> {
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Required a back call',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),

            //name
            const SizedBox(height: 16),
            CustomTextField(
              labelText: "Name",
              controller: widget.vm.nameController,
              suffixIcon: Icons.person,
            ),

            //email
            const SizedBox(height: 16),
            CustomTextField(
              labelText: "Email",
              controller: widget.vm.emailController,
              keyboardType: TextInputType.emailAddress,
              suffixIcon: Icons.email,
            ),

            //mobile number
            const SizedBox(height: 16),
            CustomTextField(
              labelText: "Mobile number",
              controller: widget.vm.mobileNoController,
              suffixIcon: Icons.call,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),
            CustomDropdown(
              labelText: "Issues",
              suffixIcon: Icons.cast_for_education,
              title: "Issues",
              controller: widget.vm.issuesController!,
              items: issueItems,
              selectedLimit: issueItems.length,
              onChanged: (String newValue) {
                widget.vm.issuesController!.text = newValue;
              },
            ),

            //Write about the problem
            const SizedBox(height: 16),
            CustomTextFieldWithImage(
              hintText: "Write about the problem",
              suffixIcon: Icons.camera_alt_outlined,
              controller: widget.vm.aboutProblemController!,
              suffixIconOnPressed: () {},
            ),

            //submit button
            const SizedBox(height: 16),
            CustomButton(
              width: double.infinity,
              title: "Submit",
              onPressed: () {
                widget.vm.handelCallBackSubmitBtn();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
