import 'package:flutter/material.dart';
import 'package:mcq/models/hero/chapter.dart';
import 'package:mcq/view_models/dark_theme_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ChapterView extends StatelessWidget {
  const ChapterView({
    super.key,
    required this.onPressedChapter,
    required this.chapter,
  });

  final Chapter chapter;
  final Function(Chapter) onPressedChapter;

  @override
  Widget build(BuildContext context) {
    var darkMode = Provider
        .of<DarkThemeProvider>(context)
        .darkTheme;
    var foregroundColor = darkMode ? Colors.white : Colors.black;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 100.w,
          height: 10.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: InkWell(
            onTap: () {
              onPressedChapter(chapter);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  leading: Image.asset(
                    "assets/images/bio.png",
                    height: 7.68156.h,
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chapter.name!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: foregroundColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${chapter.spendTime!} hr",
                            style: TextStyle(
                              fontSize: 13,
                              color: foregroundColor,
                            ),
                          ),
                          Text(
                            "${chapter.attemptQuestionCount!}/${chapter
                                .questionCount!}",
                            style: TextStyle(
                              fontSize: 13,
                              color: foregroundColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      linearPercentIndicator()
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right_sharp)),
            ),
          ),
        ),
      ),
    );
  }

  linearPercentIndicator() {
    double p = 0.0;
    if (chapter.questionCount != null || chapter.attemptQuestionCount != null) {
      final count = int.parse(chapter.questionCount!);
      final attempt = int.parse(chapter.attemptQuestionCount!);
      p = (attempt / (count / 100)) / 100;
    }

    return LinearPercentIndicator(
      padding: const EdgeInsets.all(0),
      animation: true,
      animationDuration: 2000,
      percent: p,
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Colors.greenAccent,
    );
  }
}
