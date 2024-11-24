import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq/helpers/navigation_helper.dart';
import 'package:mcq/models/subject_item_view.dart';
import 'package:mcq/views/screens/previous_year/tab/chapter_test_question_screen.dart';
import 'package:mcq/views/screens/previous_year/test_agreement.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/screens/previous_year/components/previous_year_paper.dart';
import 'package:mcq/views/screens/previous_year/components/subject_selection_button.dart';
import 'package:mcq/views/components/test_progress_view.dart';
import 'package:sizer/sizer.dart';

class PreviousYearInsideScreen extends StatefulWidget {
  const PreviousYearInsideScreen({super.key});

  @override
  State<PreviousYearInsideScreen> createState() =>
      _PreviousYearInsideScreenState();
}

class _PreviousYearInsideScreenState extends State<PreviousYearInsideScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<SubjectItem> subjectItems;

  @override
  void initState() {
    super.initState();
    subjectItems = [
      SubjectItem(title: "All", isSelected: true),
      SubjectItem(title: "Hindi", isSelected: false),
      SubjectItem(title: "English", isSelected: false),
      SubjectItem(title: "Math", isSelected: false),
      SubjectItem(title: "Reasoning", isSelected: false),
      SubjectItem(title: "GS", isSelected: false),
    ];
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Previous Year"),
                Text(
                  "Question Paper",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Colors.blue,
            child: TabBar(
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: const [
                Tab(text: 'Previous Year Paper'),
                Tab(text: 'Chapter Test'),
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
            /// FIRST SCREEN
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return  PreviousYearPaper(
                    startTestClicked: (){
                      Get.to(
                        const TestAgreement(),
                        transition: Transition.rightToLeft,
                      );
                    },
                  );
                }),

            /// SECOND SCREEN
            Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: subjectItems.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SubjectSelectionButton(
                        isSelected: subjectItems[index].isSelected!,
                        title: subjectItems[index].title!,
                        onPressed: (){},
                      );
                    },
                  ),
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return TestProgressView(
                        title: "Biology Discovery",
                        width: 100.w,
                        margin: const EdgeInsets.only(top: 10),
                        onPressed: () {
                          Get.to(
                            const ChapterTestQuestionScreen(),
                            transition: Transition.rightToLeft,
                          );
                        },
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        CustomButton(
          width: 100.w,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          title: "Unlock All Test",
          onPressed: () {},
        )
      ],
    );
  }
}
