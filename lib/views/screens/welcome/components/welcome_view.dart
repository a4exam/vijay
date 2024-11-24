import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/views/screens/welcome/welcome_utils.dart';

class WelcomeView extends StatelessWidget {
  final WelcomeTabListItem data;

  const WelcomeView({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height*.6,
            child: Image.asset(data.image),
          ),
          SizedBox(height: Get.height * .04),
          if (data.title != null)
            Text(
              data.title!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
          if (data.subTitle != null)
            Text(
              data.subTitle!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            )
        ],
      ),
    );
  }
}
