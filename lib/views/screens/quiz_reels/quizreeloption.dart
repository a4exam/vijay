import 'dart:ui';

import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String option;
  final String text;
  final int optionIndex;
  final int? selectedOptionIndex;
  final int correctOptionIndex;
  final bool showIndicators;
  final VoidCallback onSelect;

  const OptionTile({
    super.key,
    required this.option,
    required this.text,
    required this.optionIndex,
    required this.selectedOptionIndex,
    required this.correctOptionIndex,
    required this.showIndicators,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Icon? indicatorIcon;
    bool showProgressBar = false;

    if (selectedOptionIndex == null) {
      backgroundColor = Colors.grey.shade50;
    } else if (selectedOptionIndex == optionIndex) {
      if (optionIndex == correctOptionIndex) {
        backgroundColor = Colors.lightGreen.withOpacity(0.1);
        indicatorIcon = const Icon(Icons.check_circle, color: Colors.green);
        showProgressBar = true; // Show progress bar for correct option
      } else {
        backgroundColor = Colors.red.withOpacity(0.1);
        indicatorIcon = const Icon(Icons.highlight_remove, color: Colors.red);
        showProgressBar = true; // Show progress bar for selected incorrect option
      }
    } else if (optionIndex == correctOptionIndex) {
      backgroundColor = Colors.lightGreen.withOpacity(0.1);
      indicatorIcon = const Icon(Icons.check_circle, color: Colors.green);
      showProgressBar = true; // Show progress bar for correct option when incorrect option was selected
    } else {
      backgroundColor = Colors.white;
    }

    return InkWell(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                    child: Center(child: Text('$option', style: const TextStyle(fontSize: 16, color: Colors.white)))),
                const SizedBox(width: 5,),
                Expanded(child: Text(text, style: const TextStyle(fontSize: 16),)),
                if (showIndicators && indicatorIcon != null) ...[
                  const SizedBox(width: 10),
                  indicatorIcon,
                ],
              ],
            ),
            if (showProgressBar)
              Padding(
                padding: const EdgeInsets.only(left:8.0,top: 8.0),
                child: LinearProgressIndicator(
                  value: .5,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    optionIndex == correctOptionIndex ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}