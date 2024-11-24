import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mcq/views/screens/auth/toggle/toggle_screen.dart';
import 'components/welcome_view.dart';
import 'welcome_utils.dart';

class WelcomeViewModel extends GetxController {
  late List<Widget> tabs;
  late PageController pageController;
  RxInt currentPageIndex = 0.obs;

  WelcomeViewModel() {
    tabs = List.generate(
      WelcomeUtils.welcomeTabDataList.length,
      (index) => WelcomeView(
        data: WelcomeUtils.welcomeTabDataList[index],
      ),
    );

    pageController = PageController();
  }

  next() {
    if (currentPageIndex.value == 2) {
      Get.off(const ToggleScreen());
      return;
    }
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
    currentPageIndex.value++;
  }

  void onPageChanged(int value) {
    currentPageIndex.value = value;
  }
}
