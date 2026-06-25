import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_task_management_mobile_app/screens/main_screen.dart';
import 'package:tasky_task_management_mobile_app/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  final String? username;
  const MyApp({super.key, required this.username});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0XFF181818),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0XFF181818),
          foregroundColor: Color(0XFFFFFFFF),
          centerTitle: true,
        ),
        switchTheme: SwitchThemeData(
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0XFF15B86C);
            }
            return Colors.white;
          }),
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return Color(0xFF9E9E9E);
          }),
          trackOutlineColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.transparent;
            }
            return Color(0xFF9E9E9E);
          }),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: username == null ? WelcomeScreen() : MainScreen(),
    );
  }
}
