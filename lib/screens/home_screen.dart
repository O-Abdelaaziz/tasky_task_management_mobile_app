import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_task_management_mobile_app/screens/add_new_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;

  Future<void> _loadUserame() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Guest';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF181818),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Evening , $username',
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Color(0XFFFFFFFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          height: 1.5,
                        ),
                        textHeightBehavior: const TextHeightBehavior(
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'One task at a time.One step closer.',
                        style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Color(0XFFC6C6C6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.25,
                          height: 1.42,
                        ),
                        textHeightBehavior: const TextHeightBehavior(
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.light_mode, color: Colors.white),
                    onPressed: () {
                      // Handle light mode button press
                    },
                  ),
                ],
              ),
              Text(
                'Your Tasks',
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Color(0XFFFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
              ),
              Spacer(),
              Align(
                alignment: AlignmentGeometry.bottomEnd,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => AddNewTask(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF15B86C),
                    foregroundColor: Color(0XFFFFFCFC),
                    fixedSize: Size(168, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  icon: Icon(Icons.add),
                  label: Text('Add New Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
