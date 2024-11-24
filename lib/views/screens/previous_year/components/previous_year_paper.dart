import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/view_models/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PreviousYearPaper extends StatelessWidget {
  final Function startTestClicked;

  const PreviousYearPaper({
    required this.startTestClicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var darkMode = Provider.of<DarkThemeProvider>(context).darkTheme;
    var foregroundColor = darkMode ? Colors.white : Colors.black;
    var backgroundColor = darkMode ? Colors.black : Colors.white;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.black12, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "CTET 2023 बुनियाद 2.0 बैच English Demo 2",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("40 Qs . 30 mins. 80.0 marks"),
                    TextButton(
                      onPressed: () {
                        startTestClicked();
                      },
                      child:  Text(
                        "Start Test",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
            ),
            width: 92.w,
            child: const Text(
              "English, hindi",
            ),
          ),
        ],
      ),
    );
  }
}
