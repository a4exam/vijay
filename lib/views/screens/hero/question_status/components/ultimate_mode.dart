import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/views/components/circular_question_number.dart';
import 'package:mcq/views/components/expansion_tile_title.dart';
import 'package:sizer/sizer.dart';

ultimateMode({
  required BuildContext context,
  required bool isListMode,
  required List<String> alphabetList,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 1.5.h),
    child: Column(
      children: [
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: expansionTileTitle(
            context: context,
            title: "Type1",
            correctCount: "1900",
            inCorrectCount: "04",
            unattemptedCount: "10",
            markedCount: "02",
          ),
          children: [
            isListMode

                /// list mode
                ? SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: 25,
                      itemBuilder: (context, position) {
                        int showValue = position + 1;
                        return Column(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Material(
                                          elevation: 2,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 4.h,
                                            width: 4.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppColors.primaryColor),
                                            child: Text(
                                              showValue.toString(),
                                              style: TextStyle(
                                                  fontSize: 2.5.h,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        SizedBox(
                                          width: 47.w,
                                          child: Text(
                                            "How many ultimate alphabets in ABC alphabets",
                                            style: TextStyle(
                                              fontSize: 2.5.h,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: const [
                                        Spacer(),
                                        Text("DP constable 2022"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              // height: 100.h,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: alphabetList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 10.h,
                                                child: Stack(
                                                  children: [
                                                    Material(
                                                      elevation: 2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 4.h,
                                                        width: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            color: AppColors
                                                                .primaryColor),
                                                        child: Text(
                                                          showValue.toString(),
                                                          style: TextStyle(
                                                              fontSize: 2.5.h,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 3.h,
                                                      child: Material(
                                                        elevation: 2,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 4.h,
                                                          width: 4.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                          child: Text(
                                                            alphabetList[index],
                                                            style: TextStyle(
                                                                fontSize: 2.5.h,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              SizedBox(
                                                width: 47.w,
                                                child: Text(
                                                  "How many ultimate alphabets in ABC alphabets",
                                                  style: TextStyle(
                                                    fontSize: 2.5.h,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: const [
                                              Spacer(),
                                              Text("DP constable 2021"),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )

                /// Grid mode
                : SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                      itemCount: 25,
                      itemBuilder: (context, position) {
                        int showValue = position + 1;
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                circularQuestionNumber(
                                  title: (showValue.toString()),
                                ),
                                Container(
                                  height: 40,
                                  width: 1,
                                  color: Colors.grey,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                ),
                                Flexible(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 8.0,
                                    ),
                                    itemCount: alphabetList.length,
                                    itemBuilder: (context, index) {
                                      return circularQuestionNumber(
                                        title: (alphabetList[index]).toString(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.grey),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ],
    ),
  );
}
