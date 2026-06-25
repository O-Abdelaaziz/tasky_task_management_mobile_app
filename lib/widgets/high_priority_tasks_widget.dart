import 'package:flutter/material.dart';
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
        color: Color(0xFF282828),
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
                  style: TextStyle(
                    color: Color(0xFF15B86C),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 8.0),
                ...tasks.reversed
                    .where((element) => element.isHighPriority)
                    .take(4)
                    .map((task) {
                      return Row(
                        children: [
                          Checkbox(
                            activeColor: Color(0xFF15B86C),
                            value: task.isDone,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(4),
                            ),
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
                              style: TextStyle(
                                color: task.isDone == true
                                    ? Color(0xFFA0A0A0)
                                    : Color(0xFFFFFCFC),
                                fontSize: 16.0,
                                overflow: TextOverflow.ellipsis,
                                decoration: task.isDone == true
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Color(0xFFA0A0A0),
                              ),
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
                    builder: (context) => HighPriorityTasksScreen(),
                  ),
                );
                onRefresh();
              },
              child: Container(
                width: 56,
                height: 48,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF282828),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF6E6E6E), width: 2),
                ),
                child: Icon(Icons.arrow_outward, color: Color(0xFFF6F6F6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
