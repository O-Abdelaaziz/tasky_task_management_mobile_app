import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final String username;
  bool isLoading = true;
  bool isDarkMode = true;

  Future<void> _loadUserame() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Gest';
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
                    style: TextStyle(color: Color(0xFFFFFCFC), fontSize: 20.0),
                  ),
                ),
                SizedBox(height: 8.0),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentGeometry.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/avatar.png',
                            ),
                            backgroundColor: Colors.transparent,
                            radius: 60,
                          ),
                          GestureDetector(
                            onTap: () {},
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
                        style: TextStyle(
                          color: Color(0xFFFFFCFC),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 20.0,
                          letterSpacing: 0.5,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'One task at time, One step Closer.',
                        style: TextStyle(
                          color: Color(0xFFFFFCFC),
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontSize: 14.0,
                          letterSpacing: 0.5,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  'Profle Info',
                  style: TextStyle(
                    color: Color(0xFFFFFCFC),
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 20.0,
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 24.0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'User Details',
                    style: TextStyle(
                      color: Color(0xFFFFFCFC),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 16.0,
                      letterSpacing: 0.5,
                      height: 1.2,
                    ),
                  ),
                  leading: Icon(Icons.person, color: Color(0xFFFFFCFC)),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xFFFFFCFC),
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: Color(0xFF6E6E6E), thickness: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(
                      color: Color(0xFFFFFCFC),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 16.0,
                      letterSpacing: 0.5,
                      height: 1.2,
                    ),
                  ),
                  leading: Icon(Icons.dark_mode, color: Color(0xFFFFFCFC)),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (bool value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: Color(0xFF6E6E6E), thickness: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Color(0xFFFFFCFC),
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 16.0,
                      letterSpacing: 0.5,
                      height: 1.2,
                    ),
                  ),
                  leading: Icon(
                    Icons.logout_outlined,
                    color: Color(0xFFFFFCFC),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xFFFFFCFC),
                  ),
                ),
                SizedBox(height: 8),
                Divider(color: Color(0xFF6E6E6E), thickness: 1),
              ],
            ),
          );
  }
}
