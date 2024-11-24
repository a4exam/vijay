import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/models/hero/hero_response.dart';
import 'package:mcq/views/screens/question_screen/question_utils.dart';

class OneTabQuestionViewModel extends GetxController {
  final RxBool isQuestionLanguageEn, isShowQuestionNumber;
  final Future<List<QuestionListItem>> Function(int) loadQuestion;
  final Function(bool) setLoading;

  OneTabQuestionViewModel({
    required this.isQuestionLanguageEn,
    required this.isShowQuestionNumber,
    required this.loadQuestion,
    required this.setLoading,
  }) {
    initializingData();
  }

  late PageController pageController;
  late Timer timer;
  RxList<QuestionListItem> questions = RxList<QuestionListItem>([]);
  RxList<SelectedOption> selectedOptions = RxList<SelectedOption>([]);
  RxString timeText = "00:00".obs;
  RxBool showScrollUpButton = false.obs;
  RxInt questionIndex = 0.obs;
  int elapsedSeconds = 0, currentIndex = 0, previousIndex = -1, page = 1;
  bool startElapsedSeconds = true;
  ScrollController scrollController = ScrollController();

  rootLoading(val) {
    if (page == 1) {
      setLoading(val);
      startElapsedSeconds = !val;
    }
  }

  loadMoreQuestion() async {
    rootLoading(true);
    final tempQuestions = await loadQuestion(page);
    if (page == 1) {
      questions.value = tempQuestions;
      final tempSelectedOptions = List<SelectedOption>.filled(
        questions.length,
        SelectedOption(),
      );
      selectedOptions.assignAll(tempSelectedOptions);
    } else {
      questions.addAll(tempQuestions);
      final List<SelectedOption> additionalOptions =
          List<SelectedOption>.filled(
        tempQuestions.length,
        SelectedOption(),
      );
      List<SelectedOption> combinedOptions = [...selectedOptions];
      combinedOptions.addAll(additionalOptions);
      selectedOptions.assignAll(combinedOptions);
    }
    rootLoading(false);
    page++;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void initializingData() {
    loadMoreQuestion();
    pageController = PageController(initialPage: currentIndex);
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (selectedOptions.isNotEmpty &&
          !selectedOptions[currentIndex].isSelected &&
          startElapsedSeconds) {
        elapsedSeconds++;
        serTimeText();
      }
    });
  }

  serTimeText() {
    final minutes = elapsedSeconds ~/ 60;
    final seconds = elapsedSeconds % 60;
    final formattedMinutes = minutes.toString().padLeft(2, '0');
    final formattedSeconds = seconds.toString().padLeft(2, '0');
    timeText.value = '$formattedMinutes:$formattedSeconds';
  }

  void onPressedOption(
    bool isSelected,
    int index,
    String selectedOptionTitle,
  ) {
    print(selectedOptions.length);
    selectedOptions[index] = SelectedOption(
      isSelected: isSelected,
      elapsedSeconds: elapsedSeconds,
      selectedOptionTitle: selectedOptionTitle,
    );
  }

  void onPageChanged(int index) {
    previousIndex = currentIndex;
    currentIndex = index;
    questionIndex.value = index;
    if (!selectedOptions[previousIndex].isSelected) {
      selectedOptions[previousIndex] = SelectedOption(
        isSelected: false,
        elapsedSeconds: elapsedSeconds,
        selectedOptionTitle: '',
      );
    }
    if (currentIndex == questions.length - 1) {
      loadMoreQuestion();
    }
    elapsedSeconds = selectedOptions[currentIndex].elapsedSeconds;
    serTimeText();
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  List<String> getOptions(
    bool isQuestionLanguageEn,
    QuestionListItem data,
  ) {
    return isQuestionLanguageEn
        ? [
            data.options1!,
            data.options2!,
            data.options3!,
            data.options4!,
          ]
        : [
            data.options1Hi!,
            data.options2Hi!,
            data.options3Hi!,
            data.options4Hi!,
          ];
  }
}
