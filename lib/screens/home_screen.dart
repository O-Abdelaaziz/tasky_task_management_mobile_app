import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_task_management_mobile_app/models/task_model.dart';
import 'package:tasky_task_management_mobile_app/screens/add_new_task.dart';
import 'package:tasky_task_management_mobile_app/widgets/task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  bool isChecked = false;
  List<TaskModel> tasks = [];
  bool isLoading = false;

  Future<void> _loadUserame() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
    });
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final finalTasks = prefs.getString('tasks');
    if (finalTasks != null) {
      final decodedTaks = jsonDecode(finalTasks) as List<dynamic>;

      setState(() {
        tasks = decodedTaks.map((element) {
          return TaskModel.fromJson(element);
        }).toList();
        isLoading = false;
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserame();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40.0,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AddNewTask(),
              ),
            );
            if (result != null && result) {
              _loadTasks();
            }
          },
          backgroundColor: Color(0XFF15B86C),
          foregroundColor: Color(0XFFFFFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          icon: Icon(Icons.add),
          label: Text('Add New Task'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Evening , $username',
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Color(0XFFFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          height: 1.5,
                        ),
                        textHeightBehavior: const TextHeightBehavior(
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'One task at a time.One step closer.',
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Color(0XFFC6C6C6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.25,
                          height: 1.42,
                        ),
                        textHeightBehavior: const TextHeightBehavior(
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.light_mode, color: Colors.white),
                    onPressed: () {
                      // Handle light mode button press
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yuhuu ,Your work Is ',
                      style: TextStyle(
                        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                        color: Color(0XFFFFFFFF),
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          'almost done ! ',
                          style: TextStyle(
                            fontFamily:
                                GoogleFonts.plusJakartaSans().fontFamily,
                            color: Color(0XFFFFFFFF),
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        SvgPicture.asset(
                          'assets/images/waving_hand.svg',
                          width: 32,
                          height: 32,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 16),
                      child: Text(
                        'My Tasks',
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Color(0XFFFFFCFC),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TaskListWidget(
                        tasks: tasks,
                        onTap: (bool? value, int? index) async {
                          setState(() {
                            tasks[index!].isDone = value ?? false;
                          });

                          final pref = await SharedPreferences.getInstance();
                          final updatedTask = tasks
                              .map((element) => element.toJson())
                              .toList();
                          final encodeTasks = jsonEncode(updatedTask);

                          pref.setString('tasks', encodeTasks);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
