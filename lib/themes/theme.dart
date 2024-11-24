import 'package:flutter/material.dart';

import 'color.dart';


class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    //accentColor: AppColors.accentColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:  AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      titleTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
        foregroundColor: Colors.white
    ),
    textTheme: _buildTextThemeLight(),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
   // accentColor: AppColors.accentColor,
    scaffoldBackgroundColor: Colors.black87,
    appBarTheme:  AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      titleTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      foregroundColor: Colors.black
    ),
    textTheme: _buildTextThemeDark(),
  );

  static TextTheme _buildTextThemeLight() {
    return const TextTheme(
      bodySmall: TextStyle(color: Colors.black, fontSize: 14),
    );
  }

  static TextTheme _buildTextThemeDark() {
    return const TextTheme(
      bodySmall: TextStyle(color: Colors.white),
    );
  }

  static Color getContainerColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppColors.containerColorDark
        : AppColors.containerColorLight;
  }
}
