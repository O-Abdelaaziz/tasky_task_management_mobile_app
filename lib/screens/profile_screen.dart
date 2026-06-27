import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky_task_management_mobile_app/core/services/shared_preferences_manager.dart';
import 'package:tasky_task_management_mobile_app/core/theme/theme_contorller.dart';
import 'package:tasky_task_management_mobile_app/main.dart';
import 'package:tasky_task_management_mobile_app/screens/user_details_screen.dart';
import 'package:tasky_task_management_mobile_app/screens/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String motivationQuote;
  bool isLoading = true;
  File? _selectedImage;
  Uint8List? _imageBytes;

  Future<void> _loadUserame() async {
    //final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = SharedPreferencesManager().getString('username') ?? 'Gest';
      motivationQuote =
          SharedPreferencesManager().getString('motivationQuote') ??
          'Your Motivation Quote';
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserame();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'My Profile',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(height: 8.0),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.bottomRight,
                        children: [
                          // CircleAvatar(
                          //   backgroundImage: _selectedImage == null
                          //       ? AssetImage('assets/images/avatar.png')
                          //       : FileImage(_selectedImage!),
                          //   backgroundColor: Colors.transparent,
                          //   radius: 60,
                          // ),
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: _imageBytes == null
                                ? const AssetImage('assets/images/avatar.png')
                                : MemoryImage(_imageBytes!),
                          ),
                          GestureDetector(
                            onTap: () async {
                              // final XFile? image = await ImagePicker()
                              //     .pickImage(source: ImageSource.gallery);

                              // if (image != null) {
                              //   setState(() {
                              //     _selectedImage = File(image.path);
                              //   });
                              // }

                              final XFile? image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                final bytes = await image.readAsBytes();
                                setState(() {
                                  _imageBytes = bytes;
                                });
                              }
                            },
                            child: Container(
                              width: 34,
                              height: 34,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF282828),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(
                                Icons.photo_camera_outlined,
                                color: Color(0xFFFFFCFC),
                                size: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        motivationQuote,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  'Profle Info',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 24.0),
                ListTile(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(
                          username: username,
                          motivationQuote: motivationQuote,
                        ),
                      ),
                    );

                    if (result != null && result) {
                      _loadUserame();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'User Details',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  leading: Icon(Icons.person),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: 8),
                Divider(color: Color(0xFF6E6E6E), thickness: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  leading: Icon(Icons.dark_mode),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeContorller.themeNotifier,
                    builder: (context, ThemeMode mode, Widget? child) {
                      return Switch(
                        value:
                            ThemeContorller.themeNotifier.value ==
                            ThemeMode.dark,
                        onChanged: (bool value) async {
                          ThemeContorller.toggleTheme();
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: Color(0xFF6E6E6E), thickness: 1),
                ListTile(
                  onTap: () async {
                    //final prefs = await SharedPreferences.getInstance();
                    SharedPreferencesManager().remove('username');
                    SharedPreferencesManager().remove('motivationQuote');
                    SharedPreferencesManager().remove('tasks');

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Log Out',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  leading: Icon(Icons.logout_outlined),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                SizedBox(height: 8),
                Divider(color: Color(0xFF6E6E6E), thickness: 1),
              ],
            ),
          );
  }
}
