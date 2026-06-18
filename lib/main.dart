import 'package:flutter/material.dart';
import 'package:tasky_task_management_mobile_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasky',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
