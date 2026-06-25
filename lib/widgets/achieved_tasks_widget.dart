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
        color: Color(0xFF282828),
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
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Color(0XFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                '$doneTasks Out of $totalTasks Done',
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Color(0XFFF6F6F6),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25,
                ),
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
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Color(0XFFF6F6F6),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
