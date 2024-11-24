# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }

# Android support
-dontwarn android.support.**
-keep class android.support.** { *; }

# Keep classes that are referenced in Flutter plugins
#-keep public class -dontwarn com.example.myflutterplugin.MyFlutterPlugin

