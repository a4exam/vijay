import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/views/components/custom_button.dart';

forgotPasswordDoneDialog({required Function() onPressed}) {
  Get.defaultDialog(
    backgroundColor: const Color(0xFFF5F9FF),
    title: "",
    barrierDismissible: false,
    content: Column(
      children: [
        Image.asset("assets/images/resignation_done.png"),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Congratulations",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
              "Your Account is Ready to Use. You will be redirected to the Home Page in a Few Seconds.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              )),
        ),
        CustomButton(
          title: "Okay",
          onPressed: onPressed,
        )
      ],
    ),
  );
}
