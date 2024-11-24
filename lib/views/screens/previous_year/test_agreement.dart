import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/navigation_helper.dart';
import 'package:mcq/utils/dropdown_data.dart';
import 'package:mcq/views/screens/previous_year/test_start_screen.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/dropdown_widget.dart';
import 'package:sizer/sizer.dart';

class TestAgreement extends StatefulWidget {
  const TestAgreement({super.key});

  @override
  State<TestAgreement> createState() => _TestAgreementState();
}

class _TestAgreementState extends State<TestAgreement> {
  String? selectedLanguage;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("Your Test"),
     ),
     body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16.0),
       child: Column(
         children: [
           const SizedBox(height: 10),
           const Text("CRPF Constable (Technical & Tradesmen) 3 July 2023 Memory Based Paper",
           style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500)),
           const SizedBox(height: 10),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: const [
               Text("Duration: 120 Mins."),
               Text("Maximum Marks: 100.0")
             ],
           ),
           const SizedBox(height: 10),
           const Text("• The test contains 100 total questions.\n• Each question has 4 options out of which only one is correct.\n• You have to finish the test in 120 minutes.\n• You will be awarded 1 mark for each correct answer. There is 0.25 negative marking for incorrectly marked Option.\n• There is no negative marking for the questions that you have not attempted.\n• You can write this test only once. Make sure that you complete the test before you submit the test and/or close the browser.. I have read all the instructions carefully and have understood them. I agree not to cheat or use unfair means in this examination. I understand that using unfair means of any sort for my own or someone else's advantage will lead to my immediate disqualification. The decision of Testbook.com will be final in these matters and cannot be appealed.",
           style: TextStyle(fontSize: 15),),
           const SizedBox(height: 16),
           DropdownWidget(
             items: languageItems,
             labelText: "Select language",
             onChanged: (String newValue) {
               selectedLanguage=newValue;
             },
           ),
           const SizedBox(height: 16),
           CustomButton(
             title: "Agree",
             width: 100.w,
             onPressed: (){
               Get.to(
                 const TestStartScreen(),
                 transition: Transition.rightToLeft,
               );
             },
           )
         ],
       ),
     ),
   );
  }
}

