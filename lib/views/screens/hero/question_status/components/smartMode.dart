import 'package:flutter/material.dart';
import 'package:mcq/views/components/circular_question_number.dart';
import 'package:mcq/views/components/expansion_tile_title.dart';
import 'package:sizer/sizer.dart';

smartMode({
  required BuildContext context,
  required bool isListMode,
  required List<String> alphabetList,
}) {
  return Container(
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
            : Container(
                height: 100.h,
                padding: EdgeInsets.only(top: 1.h),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
  );
}
