import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/views/screens/chat/chat_screen.dart';
import 'package:mcq/views/screens/home/home_screen.dart';
import 'package:mcq/views/screens/home/home_view_model.dart';
import 'package:mcq/views/screens/quiz_reels/quiz_reels_screen.dart';

class BottomNavViewModel extends GetxController {
  late HomeViewModel homeViewModel;
  late Rx<Widget> child;
  RxInt currentIndex = 0.obs;

  BottomNavViewModel() {
    homeViewModel = Get.put(HomeViewModel());
    child = Rx<Widget>(HomeScreen(vm: homeViewModel));
  }

  onChangePageIndex(index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        child.value = HomeScreen(vm: homeViewModel);
        break;
      case 1:
        child.value = const QuizReelsPage(isFromHome: true);
        break;
      case 2:
        child.value = ChatScreen();
        break;
    }
  }
}
