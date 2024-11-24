import 'package:flutter/material.dart';
import 'package:mcq/themes/color.dart';
import 'package:mcq/utils/utils.dart';
import 'package:provider/provider.dart';

import 'package:mcq/view_models/dark_theme_provider.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.height = 45,
    this.margin,
  });

  final String title;
  final Function()? onPressed;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.textFormFieldBorderRadius,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}

class CustomBorderButton extends StatelessWidget {
  const CustomBorderButton({
    super.key,
    required this.title,
    this.onPressed,
    this.width,
    this.height = 45,
  });

  final String title;
  final Function()? onPressed;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    var darkMode = Provider.of<DarkThemeProvider>(context).darkTheme;
    var foregroundColor = darkMode ? Colors.white : Colors.black;
    var backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.textFormFieldBorderRadius,
            side: BorderSide(color: foregroundColor),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(color: foregroundColor),
        ),
      ),
    );
  }
}
