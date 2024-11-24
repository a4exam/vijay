class QuestionType {
  int? typeId;
  String? typeName;
  List<Series>? series;

  QuestionType({
    this.typeId,
    this.typeName,
    this.series,
  });

  QuestionType.fromJson(Map<String, dynamic> json) {
    typeId = json['typeId'];
    typeName = json['typeName'];
    if (json['series'] != null) {
      series = <Series>[];
      json['series'].forEach((v) {
        series!.add(Series.fromJson(v));
      });
    }
  }

  QuestionType.fromJson2(Map<String, dynamic> json) {
    typeId = json['id'];
    typeName = json['name'];
    List<dynamic> questions = json['questions'];
    series = getSeries1(questions, json['id']);
  }

  List<Series> getSeries(List<dynamic>? questions, int? typeId) {
    if (questions == null || questions.isEmpty) {
      return [];
    }
    List<Series> series = [];
    String seriesName = questions.first["series"];
    List<SeriesData> seriesDataList = [];

    for (dynamic question in questions) {
      if (question["series"] == seriesName) {
        final seriesData = SeriesData(
          questionFlag: question["questionno"],
          typeId: typeId,
          questionId: question["id"].toString(),
          question: question["question"],
          questionHi: question["question_hi"],
        );
        seriesDataList.add(seriesData);
      } else {
        final s = Series(
          seriesName: seriesName,
          seriesData: List.from(seriesDataList),
        );
        series.add(s);
        seriesName = question["series"];
        seriesDataList.clear();
        final seriesData = SeriesData(
          questionFlag: question["questionno"],
          typeId: typeId,
          questionId: question["id"].toString(),
          question: question["question"],
          questionHi: question["question_hi"],
        );
        seriesDataList.add(seriesData);
      }
    }
    if (seriesDataList.isNotEmpty) {
      final s = Series(
        seriesName: seriesName,
        seriesData: List.from(seriesDataList),
      );
      series.add(s);
      seriesDataList = [];
    }
    return series;
  }

  List<Series> getSeries1(List<dynamic>? questions, int? typeId) {
    if (questions == null || questions.isEmpty) {
      return [];
    }
    List<Series> series = [];
    int lastSeries = int.parse(questions.first["series"]);

    for (dynamic question in questions) {
      int temp = int.parse(question["series"]);
      if (temp > lastSeries) {
        lastSeries = temp;
      }
    }
    for (int i = 1; i <= lastSeries; i++) {
      final seriesDataList = questions
          .where((element) => element["series"] == i.toString())
          .toList()
          .map((e) => SeriesData(
                questionFlag: e["questionno"],
                typeId: typeId,
                questionId: e["id"].toString(),
                question: e["question"],
                questionHi: e["question_hi"],
              ))
          .toList();

      final s = Series(
        seriesName: i.toString(),
        seriesData: seriesDataList,
      );
      series.add(s);
    }

    return series;
  }
}

class Series {
  String? seriesName;
  List<SeriesData>? seriesData;

  Series({this.seriesName, this.seriesData});

  Series.fromJson(Map<String, dynamic> json) {
    seriesName = json['series'];
    if (json['question'] != null) {
      seriesData = <SeriesData>[];
      json['question'].forEach((v) {
        seriesData!.add(SeriesData.fromJson(v));
      });
    }
  }
}

class SeriesData {
  String? questionFlag;
  int? typeId;
  String? questionId;
  String? question;
  String? questionHi;

  SeriesData(
      {this.questionFlag,
      this.typeId,
      this.questionId,
      this.question,
      this.questionHi});

  SeriesData.fromJson(Map<String, dynamic> json) {
    questionFlag = json['questionFlag'];
    typeId = json['typeId'];
    questionId = json['questionId'];
    question = json['question'];
    questionHi = json['question_hi'];
  }
}
