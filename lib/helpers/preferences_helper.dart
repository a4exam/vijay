import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static const String loggedInKey = 'isLoggedIn';
  static const String darkModeKey = 'isDarkMode';
  static const String tokenKey = 'tokenKey';

  /// logged in status
  static Future<bool> getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loggedInKey) ?? false;
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey) ?? "";
  }


  static saveLoggedInStatus(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(loggedInKey, true);
    prefs.setString(tokenKey, token);
  }

  static deleteLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(loggedInKey, false);
    prefs.setString(tokenKey, "");
  }

  /// dark mode and light mode

  static Future<bool> getDarkModeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(darkModeKey) ?? false;
  }

  static saveDarkModeStatus(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(darkModeKey, isDarkMode);
  }
}
