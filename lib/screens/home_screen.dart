import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_task_management_mobile_app/models/task_model.dart';
import 'package:tasky_task_management_mobile_app/screens/add_new_task.dart';
import 'package:tasky_task_management_mobile_app/widgets/achieved_tasks_widget.dart';
import 'package:tasky_task_management_mobile_app/widgets/high_priority_tasks_widget.dart';
import 'package:tasky_task_management_mobile_app/widgets/sliver_task_list_widget.dart';

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
  int totalTasks = 0;
  int doneTasks = 0;
  double percent = 0;

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
      tasks = decodedTaks.map((element) {
        return TaskModel.fromJson(element);
      }).toList();
    } else {
      tasks = [];
    }

    _calculatePercent();

    setState(() {
      isLoading = false;
    });
  }

  void _calculatePercent() {
    totalTasks = tasks.length;
    doneTasks = tasks.where((task) => task.isDone).length;
    percent = totalTasks == 0 ? 0 : doneTasks / totalTasks;
  }

  void _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePercent();
    });

    final pref = await SharedPreferences.getInstance();
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    final encodeTasks = jsonEncode(updatedTask);

    pref.setString('tasks', encodeTasks);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
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
                  SizedBox(height: 16.0),
                  AchievedTasksWidget(
                    doneTasks: doneTasks,
                    totalTasks: totalTasks,
                    percent: percent,
                  ),
                  SizedBox(height: 16.0),
                  HighPriorityTasksWidget(
                    tasks: tasks,
                    onTap: (bool? value, int? index) {
                      _doneTask(value, index);
                    },
                    onRefresh: () {
                      _loadTasks();
                    },
                  ),
                  SizedBox(height: 16.0),
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
                ],
              ),
            ),
            isLoading
                ? SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SliverTaskListWidget(
                    tasks: tasks,
                    onTap: (bool? value, int? index) async {
                      _doneTask(value, index);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
