class RatingListItem {
  String title;
  String emoji;
  String rateValue;

  RatingListItem({
    required this.title,
    required this.emoji,
    required this.rateValue,
  });
}

class RequirementUtils {
  static final ratingList = [
    RatingListItem(
      title: "Excellent",
      emoji: "😍",
      rateValue: "5",
    ),
    RatingListItem(
      title: "Good",
      emoji: "😃",
      rateValue: "4",
    ),
    RatingListItem(
      title: "Okay",
      emoji: "😐",
      rateValue: "3",
    ),
    RatingListItem(
      title: "Bad",
      emoji: "😕",
      rateValue: "2",
    ),
    RatingListItem(
      title: "Terrible",
      emoji: "😡",
      rateValue: "1",
    ),
  ];
}
