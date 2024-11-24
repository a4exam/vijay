import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/checkScrore/checkExamResponse.dart';
import '../models/checkScrore/questionanswerresponse.dart';
import '../models/checkScrore/scoreHistoryResponse.dart';
import '../view_models/UserDataViewModel.dart';

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({super.key});

  @override
  _QuestionAnswerScreenState createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  late Future<CheckQuestionResponse> checkQuestionResponse;
  bool isHindi = true;
  String selectedSection = 'gk';
  RxList<ScoreHistoryData> scoreDataList = <ScoreHistoryData>[].obs;
  Map<int, int?> optionSelections = {};
  Map<String, Map<int, int?>> sectionSelections = {};  // Track selections by section// To store the selected option index for each question
  final PageController _pageController = PageController();
  int currentPageIndex = 0;
  int totalQuestions = 0;
  final userdataVm = Get.put(UserdataViewModel());
  @override
  void initState() {
    super.initState();
    checkQuestionResponse = fetchQuestionAnswers();
  }

  Future<CheckQuestionResponse> fetchQuestionAnswers() async {
    try {
      if (scoreDataList.isNotEmpty) {
        // Proceed only if scoreDataList has at least one element
        final response = await http.get(Uri.parse(
            'https://examopd.com/api/v1/question-answer?exam_id=${scoreDataList[0].examId}&roll_no=${scoreDataList[0].rollNo}'));

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          return CheckQuestionResponse.fromJson(responseBody);
        } else {
          throw Exception('Failed to load question answers');
        }
      } else {
        // Handle the case when scoreDataList is empty
        throw Exception('Score data list is empty');
      }
    } catch (e) {
      rethrow;
    }
  }


  void _goToNextPage(int totalQuestions) {
    if (currentPageIndex < totalQuestions - 1) {
      setState(() {
        currentPageIndex++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    }
  }

  void _goToPreviousPage() {
    if (currentPageIndex > 0) {
      setState(() {
        currentPageIndex--;
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    }
  }

  void _handleSectionChange(String newSection) {
    setState(() {
      selectedSection = newSection;

      currentPageIndex = 0;
      _pageController.jumpToPage(0);
    });
  }

  Widget buildQuestionTile(QuestionDetail question, int index) {
    int? selectedOptionIndex = sectionSelections[selectedSection]?[index];


    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Qs ${index + 1}. ',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Html(
                  data: isHindi ? question.questionHi : question.question,
                  style: {
                    "body": Style(
                      fontSize: FontSize(16.0),
                      fontWeight: FontWeight.w500,
                    ),
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          OptionTile(
            option: 'A',
            text: isHindi ? question.options1Hi : question.options1,
            optionIndex: 0,
            selectedOptionIndex: selectedOptionIndex,
            correctOptionIndex: question.correctoption,
            showIndicators: selectedOptionIndex != null,
            onSelect: () => _handleOptionSelect(index, 0, question),
          ),
          OptionTile(
            option: 'B',
            text: isHindi ? question.options2Hi : question.options2,
            optionIndex: 1,
            selectedOptionIndex: selectedOptionIndex,
            correctOptionIndex: question.correctoption,
            showIndicators: selectedOptionIndex != null,
            onSelect: () => _handleOptionSelect(index, 1, question),
          ),
          OptionTile(
            option: 'C',
            text: isHindi ? question.options3Hi : question.options3,
            optionIndex: 2,
            selectedOptionIndex: selectedOptionIndex,
            correctOptionIndex: question.correctoption,
            showIndicators: selectedOptionIndex != null,
            onSelect: () => _handleOptionSelect(index, 2, question),
          ),
          OptionTile(
            option: 'D',
            text: isHindi ? question.options4Hi : question.options4,
            optionIndex: 3,
            selectedOptionIndex: selectedOptionIndex,
            correctOptionIndex: question.correctoption,
            showIndicators: selectedOptionIndex != null,
            onSelect: () => _handleOptionSelect(index, 3, question),
          ),
          if ((isHindi ? question.options5Hi.isNotEmpty : question.options5.isNotEmpty))
            OptionTile(
              option: 'E',
              text: isHindi ? question.options5Hi : question.options5,
              optionIndex: 4,
              selectedOptionIndex: selectedOptionIndex,
              correctOptionIndex: question.correctoption,
              showIndicators: selectedOptionIndex != null,
              onSelect: () => _handleOptionSelect(index, 4, question),
            ),
          const SizedBox(height: 20),
          const Text('Description', style: TextStyle(fontSize: 16)),
          IconButton(
            icon: const Icon(Icons.expand_more),
            onPressed: () {
              // Implement your description expanding logic here
            },
          ),
        ],
      ),
    );
  }

  void _handleOptionSelect(int questionIndex, int optionIndex, QuestionDetail question) {
    setState(() {
      optionSelections[questionIndex] = optionIndex;
      if (!sectionSelections.containsKey(selectedSection)) {
        sectionSelections[selectedSection] = {};
      }
      sectionSelections[selectedSection]![questionIndex] = optionIndex;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CheckQuestionResponse>(
        future: checkQuestionResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final sections = {
              'gk': data.sectionWiseMarks.gk,
              'math': data.sectionWiseMarks.math,
              'hindi': data.sectionWiseMarks.hindi,
              'english': data.sectionWiseMarks.english,
            };

            final selectedQuestions = sections[selectedSection]?.questionDetails.values.toList() ?? [];
            totalQuestions = selectedQuestions.length;

            return Column(
              children: [
                // Section Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: sections.keys.map((section) {
                    return ElevatedButton(
                      onPressed: () => _handleSectionChange(section),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedSection == section
                            ? Colors.blue
                            : Colors.grey[300],
                      ),
                      child: Text(section.toUpperCase()),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),

                // Progress Bar with Icons

                const SizedBox(height: 10),

                // Page View for Questions
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: selectedQuestions.length,
                    itemBuilder: (context, index) {
                      final questionDetail = selectedQuestions[index];
                      return buildQuestionTile(questionDetail, index);
                    },
                    onPageChanged: (index) {
                      setState(() {
                        currentPageIndex = index;
                      });
                    },
                  ),
                ),

                // Navigation Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _goToPreviousPage,
                      child: const Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: () => _goToNextPage(totalQuestions),
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final String option;
  final String text;
  final int optionIndex;
  final int? selectedOptionIndex;
  final int correctOptionIndex;
  final bool showIndicators;  // New variable to control the visibility of indicators
  final VoidCallback onSelect;

  const OptionTile({
    Key? key,
    required this.option,
    required this.text,
    required this.optionIndex,
    required this.selectedOptionIndex,
    required this.correctOptionIndex,
    required this.showIndicators,  // Initialize the new variable
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Icon? indicatorIcon;

    if (selectedOptionIndex == null) {
      backgroundColor = Colors.white;
    } else if (selectedOptionIndex == optionIndex) {
      if (optionIndex == correctOptionIndex) {
        backgroundColor = Colors.lightGreen.withOpacity(0.5);
        indicatorIcon = const Icon(Icons.check_circle, color: Colors.green);
      } else {
        backgroundColor = Colors.red.withOpacity(0.5);
        indicatorIcon = const Icon(Icons.highlight_remove, color: Colors.red);
      }
    } else if (optionIndex == correctOptionIndex) {
      backgroundColor = Colors.lightGreen.withOpacity(0.5);
      indicatorIcon = const Icon(Icons.check_circle, color: Colors.green);
    } else {
      backgroundColor = Colors.white;
    }

    return InkWell(
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Text('$option. ', style: const TextStyle(fontSize: 16)),
            Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
            if (showIndicators && indicatorIcon != null) ...[
              const SizedBox(width: 10),
              indicatorIcon,
            ],
          ],
        ),
      ),
    );
  }
}
