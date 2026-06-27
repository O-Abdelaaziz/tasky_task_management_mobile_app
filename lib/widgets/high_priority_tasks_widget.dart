import 'package:flutter/material.dart';
import 'package:tasky_task_management_mobile_app/core/theme/theme_contorller.dart';
import 'package:tasky_task_management_mobile_app/core/widgets/custom_checkbox_field.dart';
import 'package:tasky_task_management_mobile_app/models/task_model.dart';
import 'package:tasky_task_management_mobile_app/screens/high_priority_tasks_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function(bool?, int? index) onTap;
  final VoidCallback onRefresh;

  const HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'High Priority Tasks',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 8.0),
                ...tasks.reversed
                    .where((element) => element.isHighPriority)
                    .take(4)
                    .map((task) {
                      return Row(
                        children: [
                          CustomCheckboxField(
                            value: task.isDone,
                            onChanged: (bool? value) {
                              final index = tasks.indexWhere((e) {
                                return e.id == task.id;
                              });
                              onTap(value, index);
                            },
                          ),
                          Expanded(
                            child: Text(
                              task.taskName,
                              style: task.isDone
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HighPriorityTasksScreen(onTaskChanged: onRefresh),
                  ),
                );
              },
              child: Container(
                width: 56,
                height: 48,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF6E6E6E), width: 2),
                ),
                child: Icon(
                  Icons.arrow_outward,
                  color: ThemeContorller.isDark()
                      ? Color(0XFF161F1B)
                      : Color(0xFFF6F6F6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
