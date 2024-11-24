import 'package:flutter/material.dart';
import 'package:mcq/views/screens/hero/question_type/components/question_filter.dart';
import 'package:mcq/views/screens/question_screen/re_tab_question_view/re_tab_question_screen.dart';
import 'package:mcq/views/screens/previous_year/components/drawer_previous_year.dart';
import 'package:mcq/utils/question_list.dart';
import 'package:sizer/sizer.dart';

class ChapterTestQuestionScreen extends StatefulWidget {
  const ChapterTestQuestionScreen({super.key});

  @override
  State<ChapterTestQuestionScreen> createState() =>
      _ChapterTestQuestionScreenState();
}

class _ChapterTestQuestionScreenState extends State<ChapterTestQuestionScreen>
    with WidgetsBindingObserver {
  List<String> alphabetList = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];


  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool switchvalue = false;
  List<String> selected_tagA = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        endDrawer: DrawerPreviousYear(
          callback: (val) {
            setState(() {
              switchvalue = val;
            });
          },
          isoldswaitched: switchvalue,
        ),
        appBar: AppBar(
          bottom: const TabBar(
            labelStyle: TextStyle(fontSize: 17),
            unselectedLabelStyle: TextStyle(fontSize: 15.0),
            isScrollable: true,
            tabs: [
              Tab(text: "Type1"),
              Tab(text: "Type2"),
              Tab(text: "Type3"),
              Tab(text: "Type4"),
              Tab(text: "Type5"),
              Tab(text: "Type6"),
            ],
          ),
          elevation: 10,
          shadowColor: Colors.grey,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Chapter Test"),
                  Text(
                    "Practice Book",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.translate)),
            IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Filter()),
                  // );

                  showModalBottomSheet<void>(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return QuestionFilter(
                          callback: (p0B) {
                            setState(() {
                              selected_tagA = p0B;
                            });
                          },
                          selectedFilter: selected_tagA,
                        );
                      });
                },
                icon: const Icon(
                  Icons.filter_alt_rounded,
                  color: Colors.white,
                )),
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                    // Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu));
            }),
            SizedBox(width: 3.w),
          ],
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Material(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    // height: 48,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        if (switchvalue) Row(
                          children: [
                            textNumber(),
                            Padding(
                              padding: EdgeInsets.only(left: 2.w),
                              child: Container(
                                height: 3.9.h,
                                width: 0.5.w,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                              width: 70.w,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: alphabetList.length,
                                  itemBuilder: (context, index) {
                                    return textAlphabet(index);
                                  }),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MultiSelectionQuestionScreen(
                    questionList: questionList,
                    questionLanguage: "en",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  textNumber() {
    return Container(
      alignment: Alignment.center,
      height: 4.h,
      width: 4.h,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(
                  232, 124, 124, 124),
              Color.fromARGB(
                  255, 253, 253, 253),
            ],
          ),
          // color: Colors.white,
          border:
          Border.all(color: Colors.black),
          borderRadius:
          BorderRadius.circular(60)),
      child: Text(
        "1",
        style: TextStyle(fontSize: 3.h),
      ),
    );
  }

  textAlphabet(int index) {
    return Padding(
      padding:
      EdgeInsets.only(left: 2.w),
      child: Container(
        alignment: Alignment.center,
        height: 4.h,
        width: 4.h,
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
                color: Colors.black),
            borderRadius:
            BorderRadius.circular(
                60)),
        child: Text(
          alphabetList[index],
          style: TextStyle(
              color: Colors.white,
              fontSize: 3.h),
        ),
      ),
    );
  }

}
