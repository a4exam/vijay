import 'package:flutter/material.dart';
import 'package:mcq/models/chip_items.dart';
import 'package:sizer/sizer.dart';


class ChipWidget extends StatelessWidget {
  final ChipClass data;
  final int mainID;
  final bool isSelected;
  final VoidCallback onTap;

  const ChipWidget({
    super.key,
    required this.data,
    required this.mainID,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = isSelected ? Colors.white : Colors.black;
    final circularBoxColor = isSelected ? Colors.white : Colors.black;
    final circularBoxTextColor = isSelected ? Colors.grey : Colors.white;

    return Container(
      constraints: BoxConstraints(maxWidth: 75.w, minWidth: 10.w),
      margin: EdgeInsets.symmetric(horizontal: 0.50925.w, vertical: 0.2488.h),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.2)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 1.2731.w, vertical: 0.6221.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              const Icon(
                Icons.check,
                size: 15,
                color: Colors.white,
              ),
            const SizedBox(width: 5),
            Text(
              data.title!,
              style: TextStyle(color: titleColor),
            ),
            const SizedBox(width: 5),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: circularBoxColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.transparent),
              ),
              child: Text(
                data.qsno!,
                style: TextStyle(color: circularBoxTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
