import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky_task_management_mobile_app/core/services/shared_preferences_manager.dart';
import 'package:tasky_task_management_mobile_app/models/task_model.dart';
import 'package:tasky_task_management_mobile_app/widgets/task_list_widget.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List<TaskModel> comleteTasks = [];
  bool isLoading = false;
  Future<void> _loadTasks() async {
    setState(() {
      isLoading = true;
    });

    final finalTasks = SharedPreferencesManager().getString('tasks');

    if (finalTasks != null) {
      final decodedTaks = jsonDecode(finalTasks) as List<dynamic>;
      comleteTasks = decodedTaks
          .map((element) => TaskModel.fromJson(element))
          .where((element) => element.isDone == true)
          .toList();
    } else {
      comleteTasks = [];
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
      comleteTasks.removeWhere((task) => task.id == id);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Completed Task',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : TaskListWidget(
                    tasks: comleteTasks,
                    onTap: (bool? value, int? index) async {
                      setState(() {
                        comleteTasks[index!].isDone = value ?? false;
                      });

                      // final pref = await SharedPreferences.getInstance();
                      // final updatedTask = tasks
                      //     .map((element) => element.toJson())
                      //     .toList();

                      final allData = SharedPreferencesManager().getString(
                        'tasks',
                      );
                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((element) => TaskModel.fromJson(element))
                                .toList();
                        final newInndex = allDataList.indexWhere(
                          (e) => e.id == comleteTasks[index!].id,
                        );
                        allDataList[newInndex] = comleteTasks[index!];

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
      ],
    );
  }
}
