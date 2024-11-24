import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/preferences_helper.dart';
import 'package:mcq/models/hero/chapter.dart';
import 'package:mcq/models/hero/question_type.dart';
import 'package:mcq/repository/hero_repository.dart';
import 'package:mcq/views/screens/hero/question_status/question_status_view_model.dart';
import 'package:http/http.dart' as http;

import '../../../../models/hero/question.dart';
import '../../../../models/hero/questionResponse.dart';

class QuestionTypeViewModel extends GetxController {
  final HeroRepository heroRepository = Get.put(HeroRepository());
  late Chapter chapter;
  RxBool loading = true.obs;
  RxInt selectedIndex = 0.obs;
  RxInt correctOptionIndex = 0.obs;
  List<Tab> tabs = <Tab>[];
  List<QuestionType> questionTypesList = [];

  final Rx<Data?> _questionListData = Rx<Data?>(null);

  Data? get questionListData => _questionListData.value;

  set questionListData(Data? v) => _questionListData.value = v;
   //Data? questionListData;
  late String token;
  late final QuestionStatusViewModel questionStatusViewModel;
  late List<Question> allQuestions; // List of all questions

  RxString selectedLanguage = 'Hindi'.obs; // Use RxString for reactivity

  QuestionTypeViewModel({required Chapter Function() chapter}) {
    this.chapter = chapter();
    questionStatusViewModel = QuestionStatusViewModel();
  }

  TabController? tabController;

  void initViewModel(TickerProvider tickerProvider) {
    getTab(tickerProvider);
  }

  Future<void> getTab(TickerProvider tickerProvider) async {
    token = await PreferenceHelper.getToken();

    // Fetch question types
    questionTypesList = await heroRepository.getQuestionType(
      token: token,
      chapterId: chapter.id.toString(),
    );

    // Filter question types based on the selected language
    questionTypesList = filterQuestionsByLanguage(questionTypesList, selectedLanguage.value);

    tabs = questionTypesList.map((e) => Tab(text: e.typeName)).toList();
    tabController = TabController(length: tabs.length, vsync: tickerProvider);
    tabController?.addListener(() {
      selectedIndex.value = tabController!.index;
    });

    update(); // Notify GetX about the update
    loading.value = false;
  }

  List<QuestionType> filterQuestionsByLanguage(List<QuestionType> allQuestionTypes, String language) {
    return allQuestionTypes.map((questionType) {
      var filteredSeries = questionType.series?.map((series) {
        var filteredData = series.seriesData?.where((data) {
          if (language == 'Hindi') {
            return data.questionHi != null && data.questionHi!.isNotEmpty;
          } else {
            return data.question != null && data.question!.isNotEmpty;
          }
        }).toList() ?? [];
        return Series(seriesName: series.seriesName, seriesData: filteredData);
      }).toList();
      return QuestionType(
        typeId: questionType.typeId,
        typeName: questionType.typeName,
        series: filteredSeries,
      );
    }).toList();
  }

  Future<bool> areQuestionsAvailableInLanguage(String language) async {
    List<QuestionType> filteredQuestionTypes = filterQuestionsByLanguage(questionTypesList, language);
    return filteredQuestionTypes.expand((qt) => qt.series?.expand((s) => s.seriesData ?? []) ?? []).isNotEmpty;
  }

  void updateLanguage(String newLanguage) async {
    bool isAvailable = await areQuestionsAvailableInLanguage(newLanguage);

    if (isAvailable) {
      selectedLanguage.value = newLanguage; // Update RxString
      // Refresh the question types and tabs
      await getTab(Get.find<TickerProvider>());
      update(); // Notify listeners
    } else {
      // Show a popup indicating no questions are available
     /* Get.snackbar(
        'No Questions Available',
        'There are no questions available in $newLanguage.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );*/
    }
  }

  Future<void> sendUserAnswer({
    required String questionId,
    required String chapterId,
    required String userAns,
    required String catId,
    required String time,
  }) async {
    final url = 'https://examopd.com/api/v1/saveUserAnswer';

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'question_id': questionId,
        'chapter_id': chapterId,
        'user_ans': userAns,
        'cat_id': catId,
        'time': time,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print('User answer sent successfully.');
    } else {
      // Handle error response
      print('Failed to send user answer.');
    }
  }
}









