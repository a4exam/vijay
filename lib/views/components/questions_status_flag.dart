import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class QuestionsStatusFlag extends StatelessWidget {
  final Color color;
  final String title;
  final bool isStar;
  final bool showCheckBox;
  final bool isSelected;
  final Function(bool? newValue) onChanged;

  const QuestionsStatusFlag({
    super.key,
    required this.color,
    required this.title,
    this.isStar=false,
    this.showCheckBox=false,
    this.isSelected=false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showCheckBox
            ? Container(
          height: 2.3.h,
          width: 2.3.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color,
          ),
          child: Checkbox(
            side: MaterialStateBorderSide.resolveWith(
                  (_) => const BorderSide(color: Colors.transparent),
            ),
            value: isSelected,
            onChanged: onChanged,
            activeColor: Colors.transparent,
            checkColor: Colors.black,
          ),
        )
            : Icon(
          isStar ? Icons.star : Icons.circle,
          size: 2.3.h,
          color: color,
        ),
        SizedBox(width: 2.w),
        Text(title),
      ],
    );
  }
}
