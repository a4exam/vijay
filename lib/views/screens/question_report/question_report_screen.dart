import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/components/dropdown_widget.dart';
import 'package:mcq/views/components/loading_overlay.dart';
import 'package:mcq/views/screens/question_report/question_report_view_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:mcq/utils/dropdown_data.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';

class QuestionReportScreen extends StatefulWidget {
  QuestionReportScreen({
    required this.questionEn,
    required this.questionHi,
    super.key,
  });

  String questionEn = "questionEn";
  String questionHi = "questionHi";

  @override
  State<QuestionReportScreen> createState() => _QuestionReportScreenState();
}

class _QuestionReportScreenState extends State<QuestionReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuestionReportViewModel(),
      child: Builder(
        builder: (context) {
          final viewModel = Provider.of<QuestionReportViewModel>(context, listen: false);

          return ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
            child: LoadingOverlay(
              isLoading: viewModel.isLoading,
              child: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  foregroundColor: Colors.white,
                  title: const Text(
                    'Question Report',
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize:  Size.fromHeight(48.0),
                    child: Container(
                      color: AppColors.primaryColor,
                      child: TabBar(
                        indicatorColor: Colors.white,
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Wrong Question'),
                          Tab(text: 'Repeat/Mismatch'),
                        ],
                      ),
                    ),
                  ),
                ),
                body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      /// FIRST SCREEN - WRONG QUESTION
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              'Wrong Question',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            DropdownWidget(
                              items: wrongQuestionItems,
                              labelText: "Language Of Wrong Question",
                              onChanged: (String newValue) {
                                viewModel.setLanguageOfWrongQuestion(newValue);
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: "Please try to fix this Question",
                              controller: viewModel.editQuestionController,
                              minLines: 5,
                              maxLines: 30,
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              width: 100.w,
                              title: "Submit",
                              onPressed: viewModel.wrongQuestionSubmit,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),

                      /// SECOND SCREEN - Repeat/Mismatch
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              'Repeat/Mismatch',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(),
                            DropdownWidget(
                              items: repeatAndMismatchItems,
                              labelText: "Repeat Question/Mismatch series",
                              onChanged: (String newValue) {
                                viewModel.setRepeatOrMismatch(newValue);
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: "Subject",
                              controller: viewModel.subjectController,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: "Book",
                              controller: viewModel.bookController,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: "Chapter",
                              controller: viewModel.chapterController,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: "Type",
                              controller: viewModel.typeController,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: "Question Series",
                              controller: viewModel.questionNumberController,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: "Question Number",
                              controller: viewModel.questionSeriesController,
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              width: 100.w,
                              title: "Submit",
                              onPressed: viewModel.repeatOrMismatchSubmit,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
