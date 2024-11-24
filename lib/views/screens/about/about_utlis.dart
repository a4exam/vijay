import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FollowUsItemList {
  String title;
  IconData icon;
  String url;

  FollowUsItemList(
      {required this.title, required this.icon, required this.url});
}

class AboutUtils{
  static final followUsItems = [
    FollowUsItemList(
      icon: FontAwesomeIcons.instagramSquare,
      title: "instagram",
      url: "https://www.instagram.com/examopd/",
    ),
    FollowUsItemList(
      icon: FontAwesomeIcons.facebook,
      title: "facebook",
      url: "https://m.facebook.com/Exam-OPD-103689772475746/",
    ),
    FollowUsItemList(
      icon: FontAwesomeIcons.youtube,
      title: "youtube",
      url: "https://youtube.com/channel/UCGO-CmKGkpLRafqC5tDu6ug",
    ),
    FollowUsItemList(
      icon: FontAwesomeIcons.telegram,
      title: "telegram",
      url: "https://t.me/examopd",
    ),
    FollowUsItemList(
      icon: FontAwesomeIcons.twitter,
      title: "twitter",
      url: "https://twitter.com/ExamOpd?t=5NtQ5E0m6aJZgzdKZXjm5Q&s=09",
    ),
  ];
}