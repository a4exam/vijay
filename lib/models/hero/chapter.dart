class Chapter {
  String? id;
  String? subjectId;
  String? bookId;
  String? name;
  String? hiName;
  String? image;
  String? mode;
  String? chaptersOrder;
  String? questionCount;
  String? attemptQuestionCount;
  String? spendTime;

  Chapter(
      {this.id,
      this.subjectId,
      this.bookId,
      this.name,
      this.hiName,
      this.image,
      this.mode,
      this.chaptersOrder,
      this.questionCount,
      this.attemptQuestionCount,
      this.spendTime});

  Chapter.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    subjectId = json['subject_id'].toString();
    bookId = json['book_id'].toString();
    name = json['name'].toString();
    hiName = json['hi_name'].toString();
    image = json['image'].toString();
    mode = json['mode'].toString();
    chaptersOrder = json['chapters_order'].toString();
    questionCount = json['questionCount'].toString();
    attemptQuestionCount = json['attemptQuestionCount'].toString();
    spendTime = json['spendTime'].toString();
  }
}
