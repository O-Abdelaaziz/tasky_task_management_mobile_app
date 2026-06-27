import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_task_management_mobile_app/core/services/shared_preferences_manager.dart';
import 'package:tasky_task_management_mobile_app/models/task_model.dart';
import 'package:tasky_task_management_mobile_app/widgets/task_list_widget.dart';

class HighPriorityTasksScreen extends StatefulWidget {
  final VoidCallback? onTaskChanged;
  const HighPriorityTasksScreen({super.key, required this.onTaskChanged});

  @override
  State<HighPriorityTasksScreen> createState() =>
      _HighPriorityTasksScreenState();
}

class _HighPriorityTasksScreenState extends State<HighPriorityTasksScreen> {
  List<TaskModel> tasks = [];

  bool isLoading = false;
  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });
    final finalTasks = SharedPreferencesManager().getString('tasks');

    if (finalTasks != null) {
      final decodedTaks = jsonDecode(finalTasks) as List<dynamic>;
      tasks = decodedTaks
          .map((element) => TaskModel.fromJson(element))
          .where((element) => element.isHighPriority == true)
          .toList()
          .reversed
          .toList();
    } else {
      tasks = [];
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _deleteTask(int? id) async {
    if (id == null) return;

    final allData = SharedPreferencesManager().getString('tasks');
    if (allData == null) return;

    // 1. Load ALL tasks (not just high priority)
    List<TaskModel> allTasks = (jsonDecode(allData) as List)
        .map((element) => TaskModel.fromJson(element))
        .toList();

    // 2. Remove the task by id from the full list
    allTasks.removeWhere((task) => task.id == id);

    // 3. Save the full list back
    await SharedPreferencesManager().setString(
      'tasks',
      jsonEncode(allTasks.map((e) => e.toJson()).toList()),
    );

    // 4. Update UI (filtered list for this screen)
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });

    widget.onTaskChanged?.call();

    // if (mounted) {
    //   Navigator.pop(context, true);
    // }
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'High Priority Tasks',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : TaskListWidget(
                  tasks: tasks,
                  onTap: (bool? value, int? index) async {
                    setState(() {
                      tasks[index!].isDone = value ?? false;
                    });

                    //final pref = await SharedPreferences.getInstance();
                    final allData = SharedPreferencesManager().getString(
                      'tasks',
                    );
                    if (allData != null) {
                      List<TaskModel> allDataList =
                          (jsonDecode(allData) as List)
                              .map((element) => TaskModel.fromJson(element))
                              .toList();
                      final newInndex = allDataList.indexWhere(
                        (e) => e.id == tasks[index!].id,
                      );
                      allDataList[newInndex] = tasks[index!];

                      final encodeTasks = jsonEncode(allDataList);

                      SharedPreferencesManager().setString(
                        'tasks',
                        encodeTasks,
                      );
                      _loadTasks();
                    }
                  },
                  onEdit: () {
                    _loadTasks();
                  },
                  onDelete: (int id) {
                    _deleteTask(id);
                  },
                ),
        ),
      ),
    );
  }
}
