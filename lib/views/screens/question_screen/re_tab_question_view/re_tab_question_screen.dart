import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mcq/views/screens/question_screen/question_utils.dart';
import 'package:mcq/views/screens/question_screen/components/before_selected_option.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/loading_overlay.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:mcq/views/screens/question_report/question_report_screen.dart';
import 'package:mcq/models/question_model.dart';

class MultiSelectionQuestionScreen extends StatefulWidget {
  const MultiSelectionQuestionScreen({
     super.key,
    required this.questionList,
    required this.questionLanguage,
  });

  final List<QuestionModel> questionList;
  final String questionLanguage;

  @override
  State<MultiSelectionQuestionScreen> createState() =>
      _MultiSelectionQuestionScreenState();
}

class _MultiSelectionQuestionScreenState extends State<MultiSelectionQuestionScreen> {
  ScrollController scrollController = ScrollController();
  List<SelectedOption> selectedOptions=[];
  late PageController _pageController;
  bool _showScrollUpButton = false;
  late Timer _timer;
  int _elapsedSeconds = 0;
  int _currentIndex = 0;
  int _previousIndex = -1;
  double _zoomScale = 1.0;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    selectedOptions = List<SelectedOption>.filled(
      widget.questionList.length,
      SelectedOption(
        isSelected: false,
        elapsedSeconds: 0,
        selectedOptionTitle: "",
      ),
    );

    _startTimer();
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  String _formatTime() {
    int minutes = _elapsedSeconds ~/ 60;
    int seconds = _elapsedSeconds % 60;
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');
    return '$formattedMinutes:$formattedSeconds';
  }

  void _showOptionSelected(
    bool isSelected,
    int index,
    String selectedOptionTitle,
  ) {
    setState(() {
      selectedOptions[index] = SelectedOption(
        isSelected: isSelected,
        elapsedSeconds: _elapsedSeconds,
        selectedOptionTitle: selectedOptionTitle,
      );
    });
  }

  void _handlePageChange(int index) {
    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;

      selectedOptions[_previousIndex] = SelectedOption(
        isSelected: selectedOptions[_previousIndex].isSelected,
        elapsedSeconds: _elapsedSeconds,
        selectedOptionTitle:
            selectedOptions[_previousIndex].selectedOptionTitle,
      );

      _elapsedSeconds = selectedOptions[_currentIndex].elapsedSeconds;
    });
  }

  void _clear() {
    setState(() {
      selectedOptions[_currentIndex] = SelectedOption(
        isSelected: false,
        elapsedSeconds: _elapsedSeconds,
        selectedOptionTitle: '',
      );
    });
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: widget.questionList == null,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification) {
                    setState(() {
                      _showScrollUpButton = scrollController.offset >=
                          MediaQuery.of(context).size.height / 2;
                    });
                  }
                  return false;
                },
                child: PageView.builder(
                  onPageChanged: _handlePageChange,
                  controller: _pageController,
                  itemCount: widget.questionList.length,
                  itemBuilder: (BuildContext context, int questionIndex) {
                    var questionData = widget.questionLanguage == "hi"
                        ? widget.questionList[questionIndex].hiQuestion
                        : widget.questionList[questionIndex].enQuestion;
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// topBar
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 28,
                                          width: 28,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: Colors.grey,
                                          ),
                                          child: Center(
                                              child: Text("${questionIndex + 1}")),
                                        ),
                                        Container(
                                          height: 28,
                                          width: 3,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.access_alarm),
                                    const SizedBox(width: 5),
                                    Text(
                                      _formatTime(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.star_border),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet<void>(
                                          isScrollControlled: true,
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                              height: 90.h,
                                              child: QuestionReportScreen(questionEn: ',s, ', questionHi: 'ldl',),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                          Icons.report_problem_outlined),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Share.share(
                                          "ExamOPD\n(Make learning easy)\n\nDownload this app from:\nhttps://play.google.com/store/apps",
                                          subject: "",
                                        );
                                      },
                                      icon: const FaIcon(Icons.share_outlined),
                                    ),
                                  ],
                                ),

                                /// QUESTION
                                const Divider(),
                                Text(
                                  questionData!.question!,
                                  style: TextStyle(
                                    fontSize: 26.0 * _zoomScale,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                /// book name
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    questionData!.bookName!,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                /// OPTIONS
                                const SizedBox(height: 10),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: questionData.option!.length!,
                                  itemBuilder: (context, index) {
                                    var option = questionData.option![index];
                                    return BeforeSelectedOption(
                                      title: option,
                                      selectedOption: selectedOptions[questionIndex],
                                      onChange: (String newValue) {
                                        setState(() {
                                          _showOptionSelected(
                                            true,
                                            questionIndex,
                                            newValue,
                                          );
                                        });
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          /// Ans
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text("6 Answers"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            /// PREVIOUS AND NEXT BUTTON
          ],
        ),
        floatingActionButton: AnimatedOpacity(
          opacity: _showScrollUpButton ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: FloatingActionButton(
            onPressed: () {
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Icon(Icons.arrow_upward),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            bottom: 16.0,
            right: 16.0,
            left: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CustomBorderButton(
                  title: "Mark & Next",
                  height: 40,
                  onPressed: _nextPage,
                ),
              ),
              const SizedBox(width: 16),
              CustomBorderButton(
                title: "Clear",
                height: 40,
                onPressed: _clear,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  title: "Save & Next",
                  height: 40,
                  onPressed: _nextPage,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
