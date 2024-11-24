import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';
import 'package:sizer/sizer.dart';

class SubjectSelectionButton extends StatelessWidget {
   const SubjectSelectionButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isSelected=false,
  });

  final String title;
  final bool isSelected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ), backgroundColor: isSelected ? AppColors.primaryColor : Colors.grey,
        ),
        child: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 2.80.h)),
      ),
    );
  }
}
