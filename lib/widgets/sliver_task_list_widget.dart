import 'package:flutter/material.dart';
import 'package:tasky_task_management_mobile_app/models/task_model.dart';
import 'package:tasky_task_management_mobile_app/widgets/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function(bool?, int? index) onTap;
  final Function(int id) onDelete;
  final Function onEdit;

  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                'Not Todo Found!',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsetsGeometry.only(bottom: 80),
            sliver: SliverList.builder(
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
                  onDelete: (int id) async {
                    final shouldDelete = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Delete task'),
                        content: Text(
                          'Are you sure you want to delete this task?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    if (shouldDelete == true) {
                      await onDelete(id);
                    }
                  },
                );
              },
            ),
          );
  }
}
