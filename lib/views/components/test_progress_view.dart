import 'package:flutter/material.dart';
import 'package:mcq/view_models/dark_theme_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TestProgressView extends StatelessWidget {
  const TestProgressView({
    super.key,
    required this.title,
    required this.onPressed,
    this.margin,
    this.isTrailingShow = true,
    required this.width,
  });

  final String title;
  final double width;
  final EdgeInsetsGeometry? margin;
  final bool isTrailingShow;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var darkMode = Provider.of<DarkThemeProvider>(context).darkTheme;
    var foregroundColor = darkMode ? Colors.white : Colors.black;
    var backgroundColor = darkMode ? Colors.black : Colors.white;
    return Container(
      width: width,
      height: 10.h,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: backgroundColor,
      ),
      child: InkWell(
        onTap: onPressed,
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
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 1.9209.h,
                    color: foregroundColor,
                  ),
                ),
                Text(
                  "Continue Progress",
                  style: TextStyle(
                    fontFamily: "AnekTelugu",
                    fontSize: 1.66433.h,
                    color: foregroundColor,
                  ),
                ),
                LinearPercentIndicator(
                  padding: const EdgeInsets.all(0),
                  animation: true,
                  animationDuration: 2000,
                  percent: 0.9,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.greenAccent,
                ),
              ],
            ),
            trailing: isTrailingShow
                ? Text(
                    "10/15",
                    style: TextStyle(
                      color: foregroundColor,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
