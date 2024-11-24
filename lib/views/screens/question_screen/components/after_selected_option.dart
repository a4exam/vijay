import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AfterSelectedOption extends StatelessWidget {
  final String option;
  final String selectedOption;
  final String rightOption;
  final String optionNumber;

  AfterSelectedOption({
    super.key,
    required this.option,
    required this.selectedOption,
    required this.rightOption, required this.optionNumber,
  });


  Color? iconColor;
  Color? progressColor;
  IconData? iconData;

  void init() {
    if (selectedOption == option) {
      if (optionNumber == rightOption) {
        iconColor = Colors.green;
        iconData = Icons.check_circle;
        progressColor = Colors.green;
      } else {
        iconColor = Colors.red;
        iconData = Icons.cancel_rounded;
        progressColor = Colors.red;
      }
    } else if (optionNumber == rightOption) {
      iconColor = AppColors.primaryColor;
      iconData = Icons.check_circle;
      progressColor = AppColors.primaryColor;
    } else {
      iconColor = Colors.transparent;
      iconData = Icons.check_circle;
      progressColor = AppColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Column(
      children: [
        Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
            ),
            const SizedBox(width: 10),
            Text(option)
          ],
        ),
        const SizedBox(height: 5),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 5.0,
          animationDuration: 2000,
          percent: 1,
          leading: const Text(
            "21%",
            style: TextStyle(fontSize: 16.0),
          ),
          progressColor: progressColor,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
