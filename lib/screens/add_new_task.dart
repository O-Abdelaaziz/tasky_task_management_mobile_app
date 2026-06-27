import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_task_management_mobile_app/core/services/shared_preferences_manager.dart';
import 'package:tasky_task_management_mobile_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_task_management_mobile_app/models/task_model.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  bool isHighPriority = true;

  @override
  void dispose() {
    super.dispose();
    taskNameController.dispose();
    taskDescriptionController.dispose();
    isHighPriority = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Task',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _formState,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      title: 'Task Name',
                      controller: taskNameController,
                      hintText: 'Finish UI design for login screen',
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    CustomTextFormField(
                      title: 'Task Description',
                      controller: taskDescriptionController,
                      hintText:
                          'Finish onboarding UI and hand off to \ndevs by Thursday.',
                      maxLines: 5,
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'High Priority',
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: Color(0XFFFFFCFC),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            height: 1.5,
                          ),
                        ),
                        Switch(
                          activeTrackColor: Color(0XFF15B86C),
                          value: isHighPriority,
                          onChanged: (bool value) {
                            setState(() {
                              isHighPriority = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_formState.currentState?.validate() ?? false) {
                      final tasksJson = SharedPreferencesManager().getString(
                        'tasks',
                      );

                      List<dynamic> listTasks = [];

                      if (tasksJson != null) {
                        listTasks = jsonDecode(tasksJson);
                      }

                      TaskModel taskModel = TaskModel(
                        id: listTasks.length - 1,
                        taskName: taskNameController.text,
                        taskDescription: taskDescriptionController.text,
                        isHighPriority: isHighPriority,
                      );

                      listTasks.add(taskModel.toJson());
                      final tasksEncoded = jsonEncode(listTasks);
                      await SharedPreferencesManager().setString(
                        'tasks',
                        tasksEncoded,
                      );

                      Navigator.of(context).pop(true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width - 32, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  icon: Icon(Icons.add),
                  label: Text('Add New Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
