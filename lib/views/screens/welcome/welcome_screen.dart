import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/screens/welcome/welcome_view_model.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final vm = Get.put(WelcomeViewModel());

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height * .88,
            child: PageView(
              controller: vm.pageController,
              onPageChanged: vm.onPageChanged,
              children: vm.tabs,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Obx(() {
                  if (vm.currentPageIndex.value == 2) {
                    return const Text(
                      "Start learning!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
                Expanded(child: Container()),
                FloatingActionButton(
                  onPressed: vm.next,
                  backgroundColor: AppColors.primaryColor,
                  child: const Icon(Icons.arrow_right_alt_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
