import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasky_task_management_mobile_app/core/enums/task_item_action_enum.dart';
import 'package:tasky_task_management_mobile_app/core/services/shared_preferences_manager.dart';
import 'package:tasky_task_management_mobile_app/core/theme/theme_contorller.dart';
import 'package:tasky_task_management_mobile_app/core/widgets/custom_checkbox_field.dart';
import 'package:tasky_task_management_mobile_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_task_management_mobile_app/models/task_model.dart';

class TaskItemWidget extends StatefulWidget {
  final TaskModel task;
  final Function(bool?) onChanged;
  final Function onEdit;
  final Function(int) onDelete;
  const TaskItemWidget({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ThemeContorller.isLight()
                ? Color(0xFFD1DAD6)
                : Colors.transparent,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCheckboxField(
              value: widget.task.isDone,
              onChanged: (bool? value) {
                widget.onChanged(value);
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.task.taskName,
                    style: widget.task.isDone
                        ? Theme.of(context).textTheme.titleLarge
                        : Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                  ),
                  if (widget.task.taskDescription.isNotEmpty)
                    Text(
                      widget.task.taskDescription,
                      style: widget.task.isDone
                          ? Theme.of(context).textTheme.titleLarge
                          : Theme.of(context).textTheme.titleMedium,
                    ),
                ],
              ),
            ),

            PopupMenuButton<TaskItemActionEnum>(
              onSelected: (value) async {
                switch (value) {
                  case TaskItemActionEnum.edit:
                    final result = await _showButtomSheet(context, widget.task);

                    if (result == true) {
                      widget.onEdit();
                    }
                  case TaskItemActionEnum.delete:
                    widget.onDelete(widget.task.id);
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: ThemeContorller.isDark()
                    ? (widget.task.isDone == true
                          ? Color(0xFFA0A0A0)
                          : Color(0xFF6C6C6C))
                    : (widget.task.isDone == true
                          ? Color(0xFFA6A6A6)
                          : Color(0xFF3A4640)),
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              itemBuilder: (context) => [
                ...TaskItemActionEnum.values.map((element) {
                  return PopupMenuItem<TaskItemActionEnum>(
                    value: TaskItemActionEnum.edit,
                    child: Text(element.name),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showButtomSheet(BuildContext context, TaskModel task) {
    final GlobalKey<FormState> _formState = GlobalKey<FormState>();
    final TextEditingController taskNameController = TextEditingController(
      text: task.taskName,
    );
    final TextEditingController taskDescriptionController =
        TextEditingController(text: task.taskDescription);
    bool isHighPriority = task.isHighPriority;

    return showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
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
                          final tasksJson = SharedPreferencesManager()
                              .getString('tasks');

                          List<dynamic> listTasks = [];

                          if (tasksJson != null) {
                            listTasks = jsonDecode(tasksJson);
                          }

                          TaskModel taskModel = TaskModel(
                            id: listTasks.length - 1,
                            taskName: taskNameController.text,
                            taskDescription: taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                            isDone: task.isDone,
                          );

                          final item = listTasks.firstWhere(
                            (element) => element['id'] == task.id,
                          );

                          final index = listTasks.indexOf(item);
                          listTasks[index] = taskModel;

                          final tasksEncoded = jsonEncode(listTasks);
                          await SharedPreferencesManager().setString(
                            'tasks',
                            tasksEncoded,
                          );

                          Navigator.of(context).pop(true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          MediaQuery.of(context).size.width - 32,
                          40,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      icon: Icon(Icons.edit),
                      label: Text('Edit Task'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
