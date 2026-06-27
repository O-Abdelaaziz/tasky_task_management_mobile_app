import 'package:flutter/material.dart';
import 'package:tasky_task_management_mobile_app/models/task_model.dart';
import 'package:tasky_task_management_mobile_app/widgets/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function(bool?, int? index) onTap;
  final Function onEdit;

  final Function(int id) onDelete;
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              'Not Todo Found!',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          )
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 60),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskItemWidget(
                task: tasks[index],
                onChanged: (bool? value) {
                  onTap(value, index);
                },
                onEdit: () {
                  onEdit();
                },
                onDelete: (int id) {
                  onDelete(id);
                },
              );
            },
          );
  }
}
