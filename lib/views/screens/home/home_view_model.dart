import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/preferences_helper.dart';
import 'package:mcq/models/comman/user_profile_data.dart';
import 'package:mcq/repository/home_repository.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/view_models/UserDataViewModel.dart';
import 'package:mcq/views/screens/about/about_screen.dart';
import 'package:mcq/views/screens/auth/toggle/toggle_screen.dart';
import 'package:mcq/views/screens/help/help_screen.dart';
import 'package:mcq/views/screens/help/help_view_model.dart';
import 'package:mcq/views/screens/home/home_utils.dart';
import 'package:mcq/views/screens/hero/hero/hero_screen.dart';
import 'package:mcq/views/screens/notification/notification_screen.dart';
import 'package:mcq/views/screens/play_practice/play_practice_screen.dart';
import 'package:mcq/views/screens/previous_year/previous_year_screen.dart';
import 'package:mcq/views/screens/profile/profile_screen.dart';
import 'package:mcq/views/screens/profile/profile_view_model.dart';
import 'package:mcq/views/screens/rating/rating_screen.dart';
import 'package:mcq/views/screens/requirement/requirement_screen.dart';
import 'package:mcq/views/screens/requirement/requirement_view_model.dart';
import 'package:mcq/views/screens/setting/setting_screen.dart';
import 'package:mcq/views/screens/subscription/subscription_screen.dart';

import '../../../checkScore/check_score.dart';
import '../../../checkScore/list1.dart';
import '../../../checkScore/score_card.dart';
import 'components/home_drawer_screen.dart';

class HomeViewModel extends GetxController {
  late HomeRepository homeRepository;
  late UserdataViewModel userdataVm;
  final List<String> imgList = [
    'https://i.ibb.co/rZMv2D6/man.png',
    'https://leverageedu.com/blog/wp-content/uploads/2019/09/Importance-of-Books.jpg',
  ];

  RxBool simmerLoading = false.obs;

  HomeViewModel() {
    initData();
  }

  Future<void> initData() async {
    simmerLoading.value = true;
    homeRepository = HomeRepository();
    userdataVm = Get.put(UserdataViewModel());
    await userdataVm.getUserdata();
    simmerLoading.value = false;
    //await getProfile();
  }

  Future<dynamic> getProfile() async {
    simmerLoading.value = true;
    final token = await PreferenceHelper.getToken();
    final profileData = await homeRepository.getProfile(token);
    if (profileData["responseCode"] == 1) {
      //userData.value = UserProfileData.fromJson(profileData["data"]);
    } else {
      await showDialogForAutoLogout();
      handleLogout();
      return;
    }
    simmerLoading.value = false;
  }

  showDialogForAutoLogout() async {
    Get.defaultDialog(
      title: "WARNING",
      barrierDismissible: false,
      content: const Text('Your account login in other device'),
    );

    await Future.delayed(const Duration(seconds: 5));
  }

  onDismiss() {
    Get.back();
  }

  void handleLogout() {
    PreferenceHelper.deleteLoggedInStatus();
    Get.back();
    Get.off(const ToggleScreen());
  }

  onPressedNotificationBtn() {
    Get.to(
      NotificationPage(),
      transition: Transition.rightToLeft,
    );
  }

  gotoNextScreen(Screens screen) {
    switch (screen) {
      case Screens.profile:
        Get.to(
          const ProfileScreen(),
          transition: Transition.rightToLeft,
        );
        break;
        case Screens.checkScore:
        Get.to(
          const CheckScore(),
          transition: Transition.rightToLeft,
        );
        break;
      case Screens.mySubscription:
        Get.to(const SubscriptionScreen());
        break;
      case Screens.help:
        final vm = Get.put(HelpViewModel(userData: userdataVm.userData.value!));
        Get.to(HelpScreen(vm: vm));
        break;
      case Screens.requirement:
        final vm = Get.put(RequirementViewModel(userData: userdataVm.userData.value!));
        Get.to(RequirementScreen(vm: vm));
        break;
      case Screens.rateApp:
        Get.to(const RatingScreen());
        break;
      case Screens.shareApp:
        Get.to(const RatingScreen());
        break;
      case Screens.settings:
        Get.to(const SettingScreen());
        break;
      case Screens.logout:
        showLogoutDialog();
        break;
      case Screens.hero:
        Get.to(
          const HeroScreen(),
          transition: Transition.rightToLeft,
        );
        break;
      case Screens.genius:
        // TODO: Handle this case.
        break;
      case Screens.special:
        // TODO: Handle this case.
        break;
      case Screens.preYear:
        Get.to(
          const PreviousYearScreen(),
          transition: Transition.rightToLeft,
        );
        break;
      case Screens.playAndPractice:
        Get.to(PlayPracticeScreen());
        break;
      case Screens.homeDrawer:
        Get.to(
          HomeDrawerScreen(
            callBackForGotoNewScreen: gotoNextScreen,
            onDismiss: onDismiss,
          ),
          transition: Transition.leftToRight,
        );
        break;
      case Screens.about:
        Get.to(const AboutScreen());
        break;
    }
  }

  showLogoutDialog() {
    Get.defaultDialog(
      title: "Logout",
      content: const Text("Are you sure want to logout?"),
      cancel: TextButton(
        child: Text('No', style: TextStyle(color: AppColors.primaryColor)),
        onPressed: () => Get.back(),
      ),
      confirm: TextButton(
        onPressed: handleLogout,
        child: Text('Yes', style: TextStyle(color: AppColors.primaryColor)),
      ),
    );
  }
}
