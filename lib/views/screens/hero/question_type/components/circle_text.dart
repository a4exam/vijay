import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

circleText(text) {
  return Padding(
    padding: EdgeInsets.only(left: 2.w),
    child: Container(
      alignment: Alignment.center,
      height: 5.h,
      width: 5.h,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(60)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 3.h),
      ),
    ),
  );
}
