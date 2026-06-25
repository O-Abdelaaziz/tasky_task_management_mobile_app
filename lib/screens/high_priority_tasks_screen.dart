import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_task_management_mobile_app/models/task_model.dart';
import 'package:tasky_task_management_mobile_app/widgets/task_list_widget.dart';

class HighPriorityTasksScreen extends StatefulWidget {
  const HighPriorityTasksScreen({super.key});

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

    final prefs = await SharedPreferences.getInstance();
    final finalTasks = prefs.getString('tasks');

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

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority Tasks')),
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

                    final pref = await SharedPreferences.getInstance();
                    final allData = pref.getString('tasks');
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

                      pref.setString('tasks', encodeTasks);
                      _loadTasks();
                    }
                  },
                ),
        ),
      ),
    );
  }
}
