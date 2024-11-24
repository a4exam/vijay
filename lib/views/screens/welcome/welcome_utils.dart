class WelcomeTabListItem {
  String image;
  String? title;
  String? subTitle;

  WelcomeTabListItem({required this.image, this.title, this.subTitle});
}

class WelcomeUtils {
  static final List<WelcomeTabListItem> welcomeTabDataList = [
    WelcomeTabListItem(
        image: "assets/images/pana.png",
        title: "Online Study is the",
        subTitle: "Best choice for everyone."),
    WelcomeTabListItem(
        image: "assets/images/rafiki.png",
        title: "Best platform for both",
        subTitle: "Teachers & Learners"),
    WelcomeTabListItem(
        image: "assets/images/rafiki2.png",
        title: "Learn Anytime,",
        subTitle: "Anywhere. Accelerate Your Future and beyond."),
  ];
}
