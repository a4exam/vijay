
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetContent extends StatelessWidget {
  final String title;
  final Widget child;
  final double? height;
  final Function()? onPressedBackBtn;

  const BottomSheetContent({
    super.key,
    required this.title,
    this.onPressedBackBtn,
    this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * (height ?? 0.8), // Adjust the height as needed
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          topAppBar(),
          const SizedBox(height: 10),
          Expanded(child: child)
        ],
      ),
    );
  }

  topAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50,
          child: IconButton(
            onPressed: () {
              if (onPressedBackBtn != null) {
                onPressedBackBtn!();
              } else {
                Get.back();
              }
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        Flexible(
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 50),
      ],
    );
  }
}
