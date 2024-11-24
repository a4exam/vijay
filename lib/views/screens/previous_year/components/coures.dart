import 'package:flutter/material.dart';
import 'package:mcq/view_models/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Courses extends StatelessWidget {
  final Function() onTap;

  const Courses({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var darkMode = Provider.of<DarkThemeProvider>(context).darkTheme;
    var foregroundColor = darkMode ? Colors.white : Colors.black;
    var backgroundColor = darkMode ? Colors.black : Colors.white;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                  leading: Image.asset(
                    "assets/images/bio.png",
                    height: 7.68156.h,
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delhi Police Constable",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 2.5.h,
                          color: foregroundColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "60 Previous Year Papers",
                        style: TextStyle(
                          fontFamily: "AnekTelugu",
                          fontSize: 1.66433.h,
                          color: foregroundColor,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right)),
              const SizedBox(height: 12),
              Container(
                height: 1,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
