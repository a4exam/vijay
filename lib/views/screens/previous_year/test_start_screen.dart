import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mcq/utils/question_list.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/screens/previous_year/components/drawer_previous_year.dart';
import 'package:mcq/views/screens/question_screen/re_tab_question_view/re_tab_question_screen.dart';
import 'package:sizer/sizer.dart';

class TestStartScreen extends StatefulWidget {
  const TestStartScreen({super.key});

  @override
  State<TestStartScreen> createState() => _TestStartScreenState();
}

class _TestStartScreenState extends State<TestStartScreen>
    with WidgetsBindingObserver {
  List<String> alphabetList = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];
  late bool isShowQuestionNumber;
  late bool isUltimateMode;
  late Timer _timer;
  late int _elapsedSeconds;

  @override
  void initState() {
    isShowQuestionNumber = true;
    isUltimateMode = false;
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    _elapsedSeconds = 3600;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        _elapsedSeconds--;
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

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print("stattteeeee $state");
  //   switch (state) {
  //     case AppLifecycleState.paused:
  //       print("pausedddd");
  //       stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  //       return;
  //     case AppLifecycleState.resumed:
  //       if (condition1[currentPage] != true) {
  //         stopWatchTimer.onExecute.add(StopWatchExecute.start);
  //       }
  //
  //       print("resumedddd");
  //       return;
  //     default:
  //       return;
  //   }
  // }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<String> selected_tagA = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        endDrawer: DrawerPreviousYear(callback: (bool ) {  }, isoldswaitched: false),
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
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showAlertDialog(
                          onClickedNo: (){
                            Navigator.pop(context);
                      },
                      onClickedYes: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                  );
                },
                child: const Icon(Icons.pause_circle),
              ),
              const SizedBox(width: 10),
              Text(
                _formatTime(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const Text(
                "Exam name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.translate),
            ),
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
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
                if (isUltimateMode)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Row(
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
                        Expanded(
                          child: SizedBox(
                            height: 4.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: alphabetList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return textAlphabet(index);
                                }),
                          ),
                        )
                      ],
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

  AlertDialog showAlertDialog({
    Function()? onClickedYes,
    Function()? onClickedNo
}) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      title: Column(
        children: [
          SizedBox(
            width: 70.w,
            child: const Text(
              "Are you sure you want to pause the test",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CustomBorderButton(
                  title: "No",
                  height: 40,
                  onPressed: () {
                    onClickedNo!();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  title: "Yes",
                  height: 40,
                  onPressed: () {
                    onClickedYes!();
                  },
                ),
              )
            ],
          ),
        ],
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
              Color.fromARGB(232, 124, 124, 124),
              Color.fromARGB(255, 253, 253, 253),
            ],
          ),
          // color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(60)),
      child: Text(
        "1",
        style: TextStyle(fontSize: 3.h),
      ),
    );
  }

  textAlphabet(int index) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w),
      child: Container(
        alignment: Alignment.center,
        height: 4.h,
        width: 4.h,
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(60)),
        child: Text(
          alphabetList[index],
          style: TextStyle(color: Colors.white, fontSize: 3.h),
        ),
      ),
    );
  }
}
