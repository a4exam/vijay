import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mcq/view_models/dark_theme_provider.dart';

class DialogBoxWrapper extends StatelessWidget {
  const DialogBoxWrapper({
    super.key,
    required this.title,
    required this.content,
    required this.actions,
  });

  final String title;
  final Widget content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    var darkMode = Provider.of<DarkThemeProvider>(context).darkTheme;
    var foregroundColor = darkMode ? Colors.white : Colors.black;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      title: AppBar(
        title: Text(title, style: TextStyle(color: foregroundColor)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: foregroundColor,
      ),
      content: content,
      actions: actions,
    );
  }
}
