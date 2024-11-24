import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/checkScore/list1.dart';
import 'package:mcq/checkScore/omrRow.dart';
import 'package:mcq/models/checkScrore/examsiftsetingResponse.dart';
import 'package:mcq/themes/color.dart';
import '../views/screens/checkScrore/checkscore_view_model.dart';

class OMRAnswerSheet extends StatefulWidget {
  final Sectiondetails section;

  const OMRAnswerSheet({super.key, required this.section});

  @override
  _OMRAnswerSheetState createState() => _OMRAnswerSheetState();
}

class _OMRAnswerSheetState extends State<OMRAnswerSheet> {
  final vm = Get.put(CheckScoreViewModel());

  @override
  void initState() {
    super.initState();
    vm.init(); // Initialize the ViewModel
  }

  void updateSelectedOption(int questionNumber, int option) {
    setState(() {
      vm.updateSelectedOption(widget.section.id.toString(), questionNumber, option);
    });
  }

  Future<void> _showAlreadySubmittedDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Already Submitted'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have already submitted your answers.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Get.to(ScoreCardScreen()); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (vm.loading.value) {
        return const Center(
          child: CircularProgressIndicator(), // Show loader while saving data
        );
      } else {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.section.questionNo,
                itemBuilder: (context, index) {
                  int questionNumber = index + 1;
                  int? selectedOption = vm.getSelectedOption(widget.section.id.toString(), questionNumber);

                  return OMRRow(
                    questionNumber: questionNumber,
                    selectedOption: selectedOption,
                    onSelectOption: (option) {
                      updateSelectedOption(questionNumber, option);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
              child: Material(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () async {
                    if (vm.isSubmitted.value) {
                      print("Already submitted, showing dialog");
                      await _showAlreadySubmittedDialog(); // Show alert if already submitted
                    } else {
                      if (vm.selectedOptions.isEmpty) {
                        Get.snackbar("Error", "No options selected.");
                        return;
                      }

                      bool alreadySubmitted = await vm.submitOmrResults(); // Submit results and get status

                      if (alreadySubmitted) {
                        print("Already submitted, showing dialog");
                        await _showAlreadySubmittedDialog(); // Show alert if already submitted
                      } else {
                        Get.to(ScoreCardScreen());
                      }
                    }
                  },


                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
