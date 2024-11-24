import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/screens/auth/toggle/toggle_utils.dart';

class TextView extends StatelessWidget {
  const TextView({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          width: Get.width * 0.8,
          height: Get.height * .07,
          decoration: BoxDecoration(
              color: AppColors.unselectedToggle,
              borderRadius: BorderRadius.circular(25.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style:  const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
