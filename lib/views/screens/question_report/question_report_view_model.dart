import 'package:flutter/material.dart';

class QuestionReportViewModel extends ChangeNotifier {
  TextEditingController editQuestionController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bookController = TextEditingController();
  TextEditingController chapterController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController questionSeriesController = TextEditingController();
  TextEditingController questionNumberController = TextEditingController();
  String? languageOfWrongQuestion;
  String? repeatOrMismatch;
  bool isLoading=false;

  void setLanguageOfWrongQuestion(String newValue) {
    languageOfWrongQuestion = newValue;
    notifyListeners();
  }

  void setRepeatOrMismatch(String newValue) {
    repeatOrMismatch = newValue;
    notifyListeners();
  }

  void wrongQuestionSubmit() {
    // Handle the submit action for the wrong question tab
  }

  void repeatOrMismatchSubmit() {
    // Handle the submit action for the repeat/mismatch tab
  }
}
