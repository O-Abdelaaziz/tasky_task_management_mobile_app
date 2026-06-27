import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_task_management_mobile_app/screens/completed_screen.dart';
import 'package:tasky_task_management_mobile_app/screens/home_screen.dart';
import 'package:tasky_task_management_mobile_app/screens/profile_screen.dart';
import 'package:tasky_task_management_mobile_app/screens/todo_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  // Widget _defaultScreen = HomeScreen();

  final List<Widget> _appScreens = [
    HomeScreen(),
    TodoScreen(),
    CompletedScreen(),
    ProfileScreen(),
  ];

  // void _setDefaultScreen(final int index) {
  //   setState(() {
  //     // _defaultScreen = _appScreens[index];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? Color(0XFF15B86C) : Color(0XFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/todo.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? Color(0XFF15B86C) : Color(0XFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/completed.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? Color(0XFF15B86C) : Color(0XFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profile.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? Color(0XFF15B86C) : Color(0XFFC6C6C6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      // body: _defaultScreen,
      body: SafeArea(child: _appScreens[_currentIndex]),
    );
  }
}
