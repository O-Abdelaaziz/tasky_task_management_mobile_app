import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_task_management_mobile_app/core/services/shared_preferences_manager.dart';
import 'package:tasky_task_management_mobile_app/core/theme/theme_contorller.dart';
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
  String? avatarPath;
  bool isChecked = false;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int doneTasks = 0;
  double percent = 0;

  Future<void> _loadUserame() async {
    //final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = SharedPreferencesManager().getString('username') ?? 'Guest';
      avatarPath = SharedPreferencesManager().getString('avatarPath');
    });
  }

  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });

    //final prefs = await SharedPreferences.getInstance();
    final finalTasks = SharedPreferencesManager().getString('tasks');

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

    //final pref = await SharedPreferences.getInstance();
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    final encodeTasks = jsonEncode(updatedTask);

    SharedPreferencesManager().setString('tasks', encodeTasks);
  }

  void _deleteTask(int? id) async {
    if (id == null) return;

    setState(() {
      tasks.removeWhere((task) => task.id == id);
      _calculatePercent();
    });

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    final encodeTasks = jsonEncode(updatedTask);
    SharedPreferencesManager().setString('tasks', encodeTasks);
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
                        backgroundImage: avatarPath == null
                            ? const AssetImage('assets/images/avatar.png')
                            : FileImage(File(avatarPath!)),
                      ),
                      SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Evening , $username',
                            style: Theme.of(context).textTheme.titleMedium,
                            textHeightBehavior: const TextHeightBehavior(
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'One task at a time.One step closer.',
                            style: Theme.of(context).textTheme.titleSmall,
                            textHeightBehavior: const TextHeightBehavior(
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.light_mode),
                        onPressed: () {
                          ThemeContorller.toggleTheme();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Yuhuu ,Your work Is ',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Text(
                        'almost done ! ',
                        style: Theme.of(context).textTheme.displayLarge,
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
                      style: Theme.of(context).textTheme.labelMedium,
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
                    onEdit: () {
                      _loadTasks();
                    },
                    onDelete: (int id) {
                      _deleteTask(id);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
