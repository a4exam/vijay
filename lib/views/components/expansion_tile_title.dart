import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import 'questions_status_flag.dart';

expansionTileTitle({
  required BuildContext context,
  required String title,
  required String correctCount,
  required String inCorrectCount,
  required String unattemptedCount,
  required String markedCount,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 2.5.h,
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 10),
      LinearPercentIndicator(
        padding: const EdgeInsets.all(0),
        animation: true,
        lineHeight: 0.89618.h,
        animationDuration: 2000,
        percent: 0.9,
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Theme.of(context).primaryColor,
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuestionsStatusFlag(
            color: Colors.green,
            title: correctCount, onChanged: (bool? newValue) {  },
          ),
          QuestionsStatusFlag(
            color: Colors.red,
            title: inCorrectCount, onChanged: (bool? newValue) {  },
          ),
          QuestionsStatusFlag(
            color: Colors.grey,
            title: unattemptedCount, onChanged: (bool? newValue) {  },
          ),
          QuestionsStatusFlag(
            color: Colors.yellow,
            isStar: true,
            title: markedCount, onChanged: (bool? newValue) {  },
          ),
        ],
      ),
    ],
  );
}