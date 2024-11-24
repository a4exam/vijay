import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';

circularQuestionNumber({String? title}) {

  return Container(
    alignment: Alignment.center,
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: AppColors.primaryColor,
    ),
    child: Text(
      title!,
      style: const TextStyle(fontSize: 15, color: Colors.white),
    ),
  );
}