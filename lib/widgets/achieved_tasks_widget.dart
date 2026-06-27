import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class AchievedTasksWidget extends StatelessWidget {
  final int doneTasks;
  final int totalTasks;
  final double percent;
  const AchievedTasksWidget({
    super.key,
    required this.doneTasks,
    required this.totalTasks,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Achieved Tasks',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '$doneTasks Out of $totalTasks Done',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Transform.rotate(
                angle: -math.pi / 2,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    value: percent,
                    strokeWidth: 4,
                    backgroundColor: Color(0xFF6D6D6D),
                    color: Color(0XFF15B86C),
                    valueColor: AlwaysStoppedAnimation(Color(0XFF15B86C)),
                  ),
                ),
              ),
              Text(
                '${((percent * 100).toInt())}%',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
