import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcq/utils/utils.dart';
import 'package:mcq/views/screens/bottom_navbar/bottom_nav_view_model.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State createState() {
    return _BottomNavbarScreenState();
  }
}

class _BottomNavbarScreenState extends State {
  final vm = Get.put(BottomNavViewModel());

  @override
  Widget build(context) {
    return Stack(
      children: [
        Obx(() => vm.child.value),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: Get.width,
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            child: Card(
              shape: AppShapes.cardShapeLarge,
              elevation: AppElevations.cardElevationLarge,
              color: Colors.white.withOpacity(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  bottomBarItem(
                    index: 0,
                    backgroundColor: const Color(0xFF4285F4),
                    image: "assets/images/home.svg",
                    onPressed: vm.onChangePageIndex,
                  ),
                  bottomBarItem(
                    index: 1,
                    backgroundColor: const Color(0xFFEC4134),
                    image: "assets/images/quiz.svg",
                    onPressed: vm.onChangePageIndex,
                  ),
                  bottomBarItem(
                    index: 2,
                    backgroundColor: const Color(0xFFFCBA02),
                    image: "assets/images/chat.svg",
                    onPressed: vm.onChangePageIndex,
                  ),
                ],
              ),
            ),
          ),
        )
        ///
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: FluidNavBar(
        //     icons: [
        //       FluidNavBarIcon(
        //           svgPath: "assets/images/home.svg",
        //           // icon: Icons.home,
        //           backgroundColor: const Color(0xFF4285F4),
        //           extras: {"label": "home"}),
        //       FluidNavBarIcon(
        //           svgPath: "assets/images/quiz.svg",
        //           backgroundColor: const Color(0xFFEC4134),
        //           extras: {"label": "Quiz Reel"}),
        //       FluidNavBarIcon(
        //           svgPath: "assets/images/chat.svg",
        //           backgroundColor: const Color(0xFFFCBA02),
        //           extras: {"label": "Chat"}),
        //     ],
        //     onChange: vm.onChangePageIndex,
        //     style: FluidNavBarStyle(
        //       iconSelectedForegroundColor: Colors.white,
        //       iconBackgroundColor: Colors.white,
        //       iconUnselectedForegroundColor: Colors.white,
        //       barBackgroundColor: AppColors.primaryColor,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  bottomBarItem({
    required index,
    required backgroundColor,
    required image,
    required Function(int) onPressed,
  }) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          onPressed(index);
        },
        child: CircleAvatar(
          minRadius: vm.currentIndex.value == index ? 27 : 24,
          backgroundColor: backgroundColor,
          child: SvgPicture.asset(
            image,
            color: Colors.white,
            height: vm.currentIndex.value == index ? 27 : 24,
            width: vm.currentIndex.value == index ? 27 : 24,
          ),
        ),
      ),
    );
  }
}
