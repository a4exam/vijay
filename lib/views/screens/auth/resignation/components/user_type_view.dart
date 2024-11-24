import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/utils/utils.dart';

class UserTypeView extends StatelessWidget {
  final String image;
  final String title;
  final int value;
  final int selected;
  final Function(int) onPressed;

  const UserTypeView({
    super.key,
    required this.image,
    required this.title,
    required this.onPressed,
    required this.value,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor =
        selected == value ? AppColors.primaryColor : AppColors.greyColor;
    return InkWell(
      onTap: () {
        onPressed(value);
      },
      child: Container(
        width: Get.width,
        height: Get.height * .15,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.textFormFieldBorderRadius,
          border: Border.all(
            color: selectedColor,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(image),
              const SizedBox(width: 20),
              Text(title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )),
              Expanded(child: Container()),
              Icon(
                Icons.chevron_right,
                color: selectedColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
