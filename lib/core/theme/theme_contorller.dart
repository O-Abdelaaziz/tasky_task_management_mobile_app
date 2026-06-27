import 'package:flutter/material.dart';
import 'package:tasky_task_management_mobile_app/core/services/shared_preferences_manager.dart';

class ThemeContorller {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  void init() {
    bool isDarkMode = SharedPreferencesManager().getBoolean('theme') ?? true;
    themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
    } else {
      themeNotifier.value = ThemeMode.dark;
    }
    bool isDarkMode = themeNotifier.value == ThemeMode.dark ? true : false;
    await SharedPreferencesManager().setBoolean('theme', isDarkMode);
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
  static bool isLight() => themeNotifier.value == ThemeMode.light;
}
