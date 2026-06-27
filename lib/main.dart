import 'package:flutter/material.dart';
import 'package:tasky_task_management_mobile_app/core/services/shared_preferences_manager.dart';
import 'package:tasky_task_management_mobile_app/core/theme/light_theme.dart';
import 'package:tasky_task_management_mobile_app/core/theme/theme_contorller.dart';
import 'package:tasky_task_management_mobile_app/screens/main_screen.dart';
import 'package:tasky_task_management_mobile_app/screens/welcome_screen.dart';
import 'package:tasky_task_management_mobile_app/core/theme/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // String? username = prefs.getString('username');

  await SharedPreferencesManager().init();
  ThemeContorller().init();

  String? username = SharedPreferencesManager().getString('username');

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  final String? username;
  const MyApp({super.key, required this.username});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeContorller.themeNotifier,
      builder: (context, ThemeMode mode, Widget? child) {
        return MaterialApp(
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeContorller.themeNotifier.value,
          debugShowCheckedModeBanner: false,
          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}
