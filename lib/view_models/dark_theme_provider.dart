import 'package:flutter/material.dart';

import '../helpers/preferences_helper.dart';

class DarkThemeProvider with ChangeNotifier {
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    PreferenceHelper.saveDarkModeStatus(value);
    notifyListeners();
  }
}