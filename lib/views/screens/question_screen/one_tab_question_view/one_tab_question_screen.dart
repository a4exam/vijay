import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mcq/views/screens/question_screen/one_tab_question_view/one_tab_question_view_model.dart';
import 'package:mcq/views/screens/question_screen/question_utils.dart';
import 'package:mcq/views/screens/question_report/question_report.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/loading_overlay.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:mcq/models/question_model.dart';
import '../components/show_description_view.dart';
import '../components/show_option_view.dart';

class OneTabQuestionScreen extends StatefulWidget {
  final OneTabQuestionViewModel vm;

  const OneTabQuestionScreen({super.key, required this.vm});

  @override
  State<OneTabQuestionScreen> createState() => _OneTabQuestionScreenState();
}

class _OneTabQuestionScreenState extends State<OneTabQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          /// topBar
          Container(
            color: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Question Number
                Obx(
                  () => widget.vm.isShowQuestionNumber.value
                      ? SizedBox(
                          height: Get.height * 0.08,
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.grey,
                                ),
                                child: Center(
                                  child: Obx(
                                    () => Text(
                                        "${widget.vm.questionIndex.value + 1}"),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Container(
                                width: 3,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),

                /// access icon
                const SizedBox(width: 14),
                const Icon(Icons.access_alarm),

                /// time Text
                const SizedBox(width: 5),
                Obx(
                  () => Text(
                    widget.vm.timeText.value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),

                /// book mark question
                Expanded(child: Container()),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.star_border),
                ),

                /// question report
                IconButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 90.h,
                          child: QuestionReport(
                            questionEn: '',
                            questionHi: '',
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.report_problem_outlined),
                ),

                /// share question
                IconButton(
                  onPressed: () {
                    Share.share(
                      "ExamOPD\n(Make learning easy)\n\nDownload this app from:\nhttps://play.google.com/store/apps",
                      subject: "",
                    );
                  },
                  icon: const FaIcon(Icons.share_outlined),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => PageView.builder(
                onPageChanged: widget.vm.onPageChanged,
                controller: widget.vm.pageController,
                itemCount: widget.vm.questions.length,
                itemBuilder: (BuildContext context, int index) {
                  final question = widget.vm.questions[index];
                  return SingleChildScrollView(
                    controller: widget.vm.scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// QUESTION
                              const SizedBox(height: 5),
                              Obx(
                                () => Html(
                                  data: widget.vm.isQuestionLanguageEn.value
                                      ? question.question!
                                      : question.questionHi!,
                                  style: {
                                    'body': Style(
                                      fontSize: FontSize(22.0),
                                    ),
                                  },
                                ),
                              ),

                              /// book name
                              const SizedBox(height: 10),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "questionData.bookName!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              /// OPTIONS
                              const SizedBox(height: 10),
                              Obx(
                                () {
                                  final options = widget.vm.getOptions(
                                    widget.vm.isQuestionLanguageEn.value,
                                    question,
                                  );
                                  return ShowOption(
                                    rightOption: question.correctoption!,
                                    options: options,
                                    selectedOption:
                                        widget.vm.selectedOptions[index],
                                    onTap: (selectedOption) {
                                      widget.vm.onPressedOption(
                                        true,
                                        index,
                                        selectedOption,
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        /// Ans
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text("6 Answers"),
                        ),

                        /// DESCRIPTION
                        const SizedBox(height: 10),
                        Obx(
                          () => ShowDescription(
                            descriptionDetails: question.solution,
                            isDescription:
                                widget.vm.selectedOptions[index].isSelected,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          /// PREVIOUS AND NEXT BUTTON
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: widget.vm.showScrollUpButton.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton(
          onPressed: () {
            widget.vm.scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: const Icon(Icons.arrow_upward),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          top: 4.0,
          bottom: 16.0,
          right: 16.0,
          left: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomBorderButton(
                title: "Previous",
                height: 40,
                onPressed: widget.vm.previousPage,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomButton(
                title: "Next",
                height: 40,
                onPressed: widget.vm.nextPage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
