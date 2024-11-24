import 'package:flutter/material.dart';

class DrawerItemList {
  String title;
  IconData icon;
  Screens screenName;

  DrawerItemList({
    required this.title,
    required this.icon,
    required this.screenName,
  });
}

class BookItemList {
  String title;
  String subTitle;
  String imagePath;
  Color backgroundColor;
  Screens screenName;

  BookItemList({
    required this.title,
    required this.subTitle,
    required this.imagePath,
    required this.backgroundColor,
    required this.screenName,
  });
}

enum Screens {
  profile,
  mySubscription,
  help,
  requirement,
  rateApp,
  shareApp,
  settings,
  logout,
  hero,
  genius,
  special,
  preYear,
  playAndPractice,
  checkScore,
  about,
  homeDrawer,
}

class HomeUtils {
  static final List<String> imgList = [
    'https://i.ibb.co/rZMv2D6/man.png',
    'https://leverageedu.com/blog/wp-content/uploads/2019/09/Importance-of-Books.jpg',
  ];
  static final List<BookItemList> bookList = [
    BookItemList(
      title: "Check Score",
      subTitle: "Check your Scorw",
      imagePath: "assets/images/document.gif",
      backgroundColor: const Color(0xFFF8E0EB),
      screenName: Screens.checkScore,
    ),
    BookItemList(
      title: "HERO",
      subTitle: "Practice Book",
      imagePath: "assets/images/hero.gif",
      backgroundColor: const Color(0xFFE2EFFF),
      screenName: Screens.hero,
    ),
    BookItemList(
      title: "GENIUS",
      subTitle: "Practice Book",
      imagePath: "assets/images/genius.gif",
      backgroundColor: const Color(0xFFFEDED4),
      screenName: Screens.genius,
    ),
    BookItemList(
      title: "Special 26",
      subTitle: "Practice Book",
      imagePath: "assets/images/edit.gif",
      backgroundColor: const Color(0xFFDCEBE6),
      screenName: Screens.special,
    ),
    BookItemList(
      title: "Pre.YEAR",
      subTitle: "Question Paper",
      imagePath: "assets/images/document.gif",
      backgroundColor: const Color(0xFFFDF1DC),
      screenName: Screens.preYear,
    ),
    BookItemList(
      title: "Play & practice",
      subTitle: "play with others students",
      imagePath: "assets/images/document.gif",
      backgroundColor: const Color(0xFFF8E0EB),
      screenName: Screens.playAndPractice,
    ),

  ];

  static final List<DrawerItemList> drawerList = [
    DrawerItemList(
      icon: Icons.person,
      title: "Profile",
      screenName: Screens.profile,
    ),
    DrawerItemList(
      icon: Icons.shopping_cart,
      title: "My Subscription",
      screenName: Screens.mySubscription,
    ),
    DrawerItemList(
      icon: Icons.contact_support,
      title: "Help",
      screenName: Screens.help,
    ),
    DrawerItemList(
      icon: Icons.message,
      title: "Requirement",
      screenName: Screens.requirement,
    ),
    DrawerItemList(
      icon: Icons.share,
      title: "Rate App",
      screenName: Screens.shareApp,
    ),
    DrawerItemList(
      icon: Icons.contact_support,
      title: "Share App",
      screenName: Screens.help,
    ),
    DrawerItemList(
      icon: Icons.settings,
      title: "Settings",
      screenName: Screens.settings,
    ),
    DrawerItemList(
      icon: Icons.follow_the_signs,
      title: "About",
      screenName: Screens.about
      ,
    ),
    DrawerItemList(
      icon: Icons.logout,
      title: "Logout",
      screenName: Screens.logout,
    ),
  ];
}
