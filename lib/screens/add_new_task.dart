import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController taskNameComntroller = TextEditingController();
  final TextEditingController taskDescriptionComntroller =
      TextEditingController();
  bool isHighPriority = true;

  @override
  void dispose() {
    super.dispose();
    taskNameComntroller.dispose();
    taskDescriptionComntroller.dispose();
    isHighPriority = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF181818),
      appBar: AppBar(
        backgroundColor: Color(0XFF181818),
        foregroundColor: Color(0XFFFFFFFF),
        title: Text('Add New Task'),
        centerTitle: true,
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
                    Text(
                      'Task Name',
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        color: Color(0XFFFFFCFC),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: taskNameComntroller,
                      decoration: InputDecoration(
                        hintText: 'Finish UI design for login screen',
                        hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
                        filled: true,
                        fillColor: Color(0XFF282828),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        // 2. Border when validator returns an error and the field is focused
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.5,
                          ),
                        ),
                      ),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Task Description',
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        color: Color(0XFFFFFCFC),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: taskDescriptionComntroller,
                      decoration: InputDecoration(
                        hintText:
                            'Finish onboarding UI and hand off to \ndevs by Thursday.',
                        hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
                        filled: true,
                        fillColor: Color(0XFF282828),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        // 2. Border when validator returns an error and the field is focused
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.5,
                          ),
                        ),
                      ),
                      cursorColor: Colors.white,
                      maxLines: 5,
                      style: const TextStyle(color: Colors.white),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task name';
                        }
                        return null;
                      },
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
                      Map<String, dynamic> task = {
                        'taskName': taskNameComntroller.text,
                        'taskDescription': taskDescriptionComntroller.text,
                        'taskPriority': isHighPriority,
                      };

                      final preferences = await SharedPreferences.getInstance();
                      final tasksJson = preferences.getString('tasks');
                      List<dynamic> listTasks = [];
                      if (tasksJson != null) {
                        listTasks = jsonDecode(tasksJson);
                      }
                      listTasks.add(task);
                      final tasksEncoded = jsonEncode(listTasks);
                      await preferences.setString('tasks', tasksEncoded);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF15B86C),
                    foregroundColor: Color(0XFFFFFCFC),
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
