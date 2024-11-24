import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mcq/themes/theme.dart';
import 'package:mcq/view_models/dark_theme_provider.dart';
import 'package:mcq/views/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'helpers/navigation_helper.dart';
import 'helpers/preferences_helper.dart';

main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(
      Sizer(builder: (context, orientation, deviceType) {
    return const MyApp();
  }));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await PreferenceHelper.getDarkModeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext? context, value, Widget? child) {
          return GetMaterialApp(
            navigatorKey: NavigatorHelper.navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: themeChangeProvider.darkTheme
                ? AppTheme.darkTheme
                : AppTheme.lightTheme,
            home:  SplashScreen(),
          );
        },
      ),
    );
  }
}
