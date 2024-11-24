import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/circular_question_number.dart';
import 'package:mcq/views/components/expansion_tile_title.dart';
import 'package:mcq/views/components/questions_status_flag.dart';
import 'package:sizer/sizer.dart';

class DrawerPreviousYear extends StatefulWidget {
  Function(bool) callback;
  bool isoldswaitched;

  DrawerPreviousYear({
    super.key,
    required this.callback,
    required this.isoldswaitched,
  });

  @override
  State<DrawerPreviousYear> createState() => _DrawerPreviousYearState();
}

class _DrawerPreviousYearState extends State<DrawerPreviousYear> {
  bool isSwitched = false;
  bool isListMode = false;
  bool isUltimateMode = false;
  bool _showCheckBox = false;

  var title = ["Unseen", "Unattempted", "Marked","Attempted"];
  var color = [Colors.white, Colors.grey, Colors.yellow,Colors.purple];
  var isSelected = [false, false, false,false];

  @override
  void initState() {
    super.initState();
    setState(() {
      isSwitched = widget.isoldswaitched;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              color: AppColors.primaryColor,
              child: SafeArea(
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isListMode = !isListMode;
                        });
                      },
                      icon: Icon(
                        isListMode ? Icons.view_module : Icons.view_agenda,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: ListView(
            children: [
              /// topHeaderWidget
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4.w,
                      ),
                      itemCount: title.length,
                      itemBuilder: (BuildContext context, int index) {
                        return QuestionsStatusFlag(
                          title: title[index],
                          color: color[index],
                          isSelected: isSelected[index],
                          showCheckBox: _showCheckBox,
                          onChanged: (newValue) {
                            setState(
                              () {
                                isSelected[index] = newValue!;
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              /// content
              const Divider(color: Colors.grey),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                child: ExpansionTile(
                  textColor: Colors.black.withOpacity(0.7),
                  tilePadding: const EdgeInsets.all(0),
                  title: expansionTileTitle(
                    title: "General English",
                    correctCount: "1900",
                    inCorrectCount: "04",
                    unattemptedCount: "10",
                    markedCount: "02",
                    context: context,
                  ),
                  children: [
                    isListMode
                    /// List Mode....
                        ? SizedBox(
                            height: 100.h,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 25,
                              itemBuilder: (context, position) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            circularQuestionNumber(
                                              title: position.toString(),
                                            ),
                                            SizedBox(width: 2.w),
                                            SizedBox(
                                              width: 47.w,
                                              child: Text(
                                                "How many  alphabets in ABC alphabets",
                                                style: TextStyle(
                                                  fontSize: 2.5.h,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Align(
                                          alignment: Alignment.centerRight,
                                          child: Text("DP constable 2022"),
                                        ),
                                        const Divider()
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                    /// Grid Mode....
                        : Container(
                            height: 100.h,
                            padding: EdgeInsets.only(top: 1.h),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              itemCount: 25,
                              itemBuilder: (context, position) {
                                return circularQuestionNumber(
                                  title: (position + 1).toString(),
                                );
                              },
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: (
            CustomButton(title: "Submit",onPressed: (){},)
            ),
          ),
        ),
      ),
    );
  }
}
