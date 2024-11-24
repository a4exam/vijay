class QuestionModel {
  Question? hiQuestion;
  Question? enQuestion;

  QuestionModel({
    this.hiQuestion,
    this.enQuestion,
  });

  QuestionModel.fromJson(Map<String, dynamic> json) {
    hiQuestion = json['hiQuestion'] != null
        ? Question.fromJson(json['hiQuestion'])
        : null;
    enQuestion = json['enQuestion'] != null
        ? Question.fromJson(json['enQuestion'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (hiQuestion != null) {
      data['hiQuestion'] = hiQuestion?.toJson();
    }
    if (enQuestion != null) {
      data['enQuestion'] = enQuestion?.toJson();
    }
    return data;
  }
}

class Question {
  String? bookName;
  String? question;
  List<String>? option;
  String? solution;
  String? rightOption;

  Question({
    this.bookName,
    this.question,
    this.option,
    this.solution,
    this.rightOption,
  });

  Question.fromJson(Map<String, dynamic> json) {
    bookName = json['bookName'];
    question = json['question'];
    option = json['option'];
    solution = json['solution'];
    rightOption = json['rightOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['bookName'] = bookName;
    data['question'] = question;
    data['option'] = option;
    data['solution'] = solution;
    data['rightOption'] = rightOption;
    return data;
  }
}


