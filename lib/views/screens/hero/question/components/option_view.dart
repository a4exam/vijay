import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/models/hero/question.dart';
import 'package:mcq/models/hero/questionResponse.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/components/custom_spacer.dart';
import 'package:mcq/views/screens/hero/question/question_util.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../question_type/question_type_view_model.dart';

Widget optionView({
  required Question question,
  required Function({
  required OptionFlag optionFlag,
  required bool hasEnableOption,
  }) onTap,
  required Function({
  required OptionFlag optionFlag,
  required bool hasEnableOption,
  }) onTapEnableButton,
}) {
  final QuestionTypeViewModel vm = Get.find<QuestionTypeViewModel>();

  return Obx(() {
    final language = vm.selectedLanguage.value;


    return question.isSelectByUser.value
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eachOptionSubmit(
          optionFlag: OptionFlag.A,
          selectedOption: question.selectedOptionByUser,
          rightOption: question.correctoption,
          text: language == 'Hindi'
              ? question.options1Hi ?? "विकल्प 1"
              : question.options1 ?? "Option 1",
          percentage: question.optionA.toString(),
        ),
        eachOptionSubmit(
          optionFlag: OptionFlag.B,
          selectedOption: question.selectedOptionByUser,
          rightOption: question.correctoption,
          text: language == 'Hindi'
              ? question.options2Hi ?? "विकल्प 2"
              : question.options2 ?? "Option 2",
          percentage: question.optionB.toString()),

        eachOptionSubmit(
          optionFlag: OptionFlag.C,
          selectedOption: question.selectedOptionByUser,
          rightOption: question.correctoption,
          text: language == 'Hindi'
              ? question.options3Hi ?? "विकल्प 3"
              : question.options3 ?? "Option 3",
          percentage: question.optionC.toString(),
        ),
        eachOptionSubmit(
          optionFlag: OptionFlag.D,
          selectedOption: question.selectedOptionByUser,
          rightOption: question.correctoption,
          text: language == 'Hindi'
              ? question.options4Hi ?? "विकल्प 4"
              : question.options4 ?? "Option 4",
          percentage:question.optionD.toString(),
        ),
      ],
    )
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eachOptionUnSubmit(
          optionFlag: OptionFlag.A,
          text: language == 'Hindi'
              ? question.options1Hi ?? "विकल्प 1"
              : question.options1 ?? "Option 1",
          hasEnableOption1: question.hasEnableOption1,
          onTap: onTap,
          onTapEnableButton: onTapEnableButton,
        ),
        eachOptionUnSubmit(
          optionFlag: OptionFlag.B,
          text: language == 'Hindi'
              ? question.options2Hi ?? "विकल्प 2"
              : question.options2 ?? "Option 2",
          hasEnableOption1: question.hasEnableOption2,
          onTap: onTap,
          onTapEnableButton: onTapEnableButton,
        ),
        eachOptionUnSubmit(
          optionFlag: OptionFlag.C,
          text: language == 'Hindi'
              ? question.options3Hi ?? "विकल्प 3"
              : question.options3 ?? "Option 3",
          hasEnableOption1: question.hasEnableOption3,
          onTap: onTap,
          onTapEnableButton: onTapEnableButton,
        ),
        eachOptionUnSubmit(
          optionFlag: OptionFlag.D,
          text: language == 'Hindi'
              ? question.options4Hi ?? "विकल्प 4"
              : question.options4 ?? "Option 4",
          hasEnableOption1: question.hasEnableOption4,
          onTap: onTap,
          onTapEnableButton: onTapEnableButton,
        ),
      ],
    );
  });
}

String _calculatePercentage(int count, int total) {
  if (total == 0) return "0%";
  final percentage = (count / total) * 100;
  return "${percentage.toStringAsFixed(1)}%";
}

Widget eachOptionSubmit({
  required OptionFlag optionFlag,
  String? selectedOption,
  String? rightOption,
  required String text,
  required String percentage,
}) {
  final isSelected = selectedOption == optionFlag.getOptionNumber();
  final isCorrect = optionFlag.getOptionNumber() == rightOption;

  final color = isSelected
      ? isCorrect
      ? Colors.green
      : Colors.red
      : AppColors.primaryColor;

  final bgColor = isCorrect
      ? Colors.green.withOpacity(0.1)
      : isSelected
      ? color.withOpacity(0.1)
      : color.withAlpha(20);

  final percentString = percentage.replaceAll('%', '').replaceAll(',', '');
  final percent = (double.tryParse(percentString) ?? 0) / 100.0;


  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(19),
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.threeLine,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isCorrect ? Colors.green : color,
                borderRadius: BorderRadius.circular(60),
              ),
              alignment: Alignment.center,
              height: 2.9.h,
              width: 2.9.h,
              child: Text(
                optionFlag.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 2.h,
                ),
              ),
            ),
            wSpacer(20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            wSpacer(80),
            Expanded(
              child: LinearPercentIndicator(
                padding: const EdgeInsets.all(0),
                animation: true,
                percent: percent,
                progressColor: isCorrect ? Colors.green : color,
                backgroundColor: color.withAlpha(40),
              ),
            ),
            wSpacer(10),
            Text(
              percentage,
              style: TextStyle(
                color: isCorrect ? Colors.green : color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: isCorrect
            ? Container(
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(60),
          ),
          alignment: Alignment.center,
          height: 2.9.h,
          width: 2.9.h,
          child: const Icon(Icons.check_circle, color: Colors.green),
        )
            : isSelected
            ? const Icon(Icons.cancel, color: Colors.red)
            : Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(60),
          ),
          alignment: Alignment.center,
          height: 2.9.h,
          width: 2.9.h,
        ),
      ),
    ),
  );
}

Widget eachOptionUnSubmit({
  required OptionFlag optionFlag,
  required String text,
  required RxBool hasEnableOption1,
  required Function({
  required OptionFlag optionFlag,
  required bool hasEnableOption,
  }) onTap,
  required Function({
  required OptionFlag optionFlag,
  required bool hasEnableOption,
  }) onTapEnableButton,
}) {
  return Obx(
        () {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          decoration: BoxDecoration(
            color: hasEnableOption1.value
                ? AppColors.primaryColor.withAlpha(20)
                : const Color(0xFFC7C7C7),
            borderRadius: BorderRadius.circular(19),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            onTap: () {
              onTap(
                hasEnableOption: hasEnableOption1.value,
                optionFlag: optionFlag,
              );
            },
            title: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: hasEnableOption1.value
                        ? AppColors.primaryColor
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  alignment: Alignment.center,
                  height: 2.9.h,
                  width: 2.9.h,
                  child: Text(
                    optionFlag.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 2.h,
                    ),
                  ),
                ),
                wSpacer(20),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      color: hasEnableOption1.value
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.cancel_rounded,
                color: hasEnableOption1.value ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                onTapEnableButton(
                  optionFlag: optionFlag,
                  hasEnableOption: !hasEnableOption1.value,
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
