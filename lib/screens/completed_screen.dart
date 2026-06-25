import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

    final prefs = await SharedPreferences.getInstance();
    final finalTasks = prefs.getString('tasks');

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
            style: TextStyle(color: Color(0xFFFFFCFC), fontSize: 20.0),
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

                      final pref = await SharedPreferences.getInstance();
                      // final updatedTask = tasks
                      //     .map((element) => element.toJson())
                      //     .toList();

                      final allData = pref.getString('tasks');
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

                        pref.setString('tasks', encodeTasks);
                        _loadTasks();
                      }
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
