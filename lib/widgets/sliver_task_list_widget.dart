import 'package:flutter/material.dart';
import 'package:tasky_task_management_mobile_app/models/task_model.dart';

class SliverTaskListWidget extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function(bool?, int? index) onTap;
  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                'Not Todo Found!',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsetsGeometry.only(bottom: 80),
            sliver: SliverList.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF282828),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          activeColor: Color(0xFF15B86C),
                          value: tasks[index].isDone,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(4),
                          ),
                          onChanged: (bool? value) {
                            onTap(value, index);
                          },
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                tasks[index].taskName,
                                style: TextStyle(
                                  color: tasks[index].isDone == true
                                      ? Color(0xFFA0A0A0)
                                      : Color(0xFFFFFCFC),
                                  fontSize: 16.0,
                                  overflow: TextOverflow.ellipsis,
                                  decoration: tasks[index].isDone == true
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  decorationColor: Color(0xFFA0A0A0),
                                ),
                                maxLines: 1,
                              ),
                              if (tasks[index].taskDescription.isNotEmpty)
                                Text(
                                  tasks[index].taskDescription,
                                  style: TextStyle(
                                    color: Color(0xFFC6C6C6),
                                    fontSize: 14.0,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_vert,
                            color: tasks[index].isDone == true
                                ? Color(0xFFA0A0A0)
                                : Color(0xFFFFFCFC),
                            size: 24.0,
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
