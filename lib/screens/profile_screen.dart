import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasky_task_management_mobile_app/core/services/shared_preferences_manager.dart';
import 'package:tasky_task_management_mobile_app/core/theme/theme_contorller.dart';
import 'package:tasky_task_management_mobile_app/screens/user_details_screen.dart';
import 'package:tasky_task_management_mobile_app/screens/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String? avatarPath;
  late String motivationQuote;
  bool isLoading = true;
  //File? _selectedImage;
  //Uint8List? _imageBytes;

  Future<void> _loadUserame() async {
    //final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = SharedPreferencesManager().getString('username') ?? 'Gest';
      avatarPath = SharedPreferencesManager().getString('avatarPath');
      motivationQuote =
          SharedPreferencesManager().getString('motivationQuote') ??
          'Your Motivation Quote';
      isLoading = false;
    });
  }

  void _saveImage(XFile image) async {
    final appDirectory = await getApplicationDocumentsDirectory();
    // final path = appDirectory.path;
    // final file = File('$path/avatar.png');
    // await file.writeAsBytes(image);
    // setState(() {
    //   _selectedImage = file;
    // });

    final newFile = await File(
      image.path,
    ).copy('${appDirectory.path}/${image.name}');
    SharedPreferencesManager().setString('avatar', newFile.path);
    // setState(() {
    //   _imageBytes = File('${appDirectory.path}/avatar.png').readAsBytesSync();
    // });
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
                            //  backgroundImage: _imageBytes == null
                            //     ? const AssetImage('assets/images/avatar.png')
                            //     : MemoryImage(_imageBytes!),
                            backgroundImage: avatarPath == null
                                ? const AssetImage('assets/images/avatar.png')
                                : FileImage(File(avatarPath!)),
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

                              // final XFile? image = await ImagePicker()
                              //     .pickImage(source: ImageSource.gallery);
                              // if (image != null) {
                              //   final bytes = await image.readAsBytes();
                              //   setState(() {
                              //     _imageBytes = bytes;
                              //   });
                              // }
                              showImageSourceDialog(
                                context,
                                selectedFile: (XFile image) async {
                                  //final bytes = await image.readAsBytes();
                                  _saveImage(image);

                                  setState(() {
                                    // _imageBytes = bytes;
                                    avatarPath = image.path;
                                  });
                                },
                              );
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
                    SharedPreferencesManager().remove('avatarPath');

                    setState(() {
                      avatarPath = null; // 🔑 reset state immediately
                    });

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

Future<bool> _requestGalleryPermission() async {
  // Android 13+ uses READ_MEDIA_IMAGES, older uses READ_EXTERNAL_STORAGE
  final status = await Permission.photos.request();
  return status.isGranted;
}

Future<bool> _requestCameraPermission() async {
  final status = await Permission.camera.request();
  return status.isGranted;
}

void showImageSourceDialog(
  BuildContext context, {
  required Function(XFile) selectedFile,
}) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(
        'Select Image Source',
        style: Theme.of(context).textTheme.labelSmall,
      ),
      children: [
        SimpleDialogOption(
          child: Row(
            children: [
              Icon(Icons.photo),
              SizedBox(width: 8.0),
              Text('Gallery'),
            ],
          ),
          onPressed: () async {
            if (await _requestGalleryPermission()) {
              final XFile? image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) selectedFile(image);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gallery permission denied')),
              );
            }
            Navigator.pop(context);
          },
        ),
        SimpleDialogOption(
          child: Row(
            children: [
              Icon(Icons.camera),
              SizedBox(width: 8.0),
              Text('Camera'),
            ],
          ),
          onPressed: () async {
            if (await _requestCameraPermission()) {
              final XFile? image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) selectedFile(image);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Camera permission denied')),
              );
            }
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

// void showImageSourceDialog(
//   BuildContext context, {
//   required Function(XFile) selectedFile,
// }) {
//   showDialog(
//     context: context,
//     builder: (context) => SimpleDialog(
//       title: Text(
//         'Select Image Source',
//         style: Theme.of(context).textTheme.labelSmall,
//       ),
//       children: [
//         SimpleDialogOption(
//           child: Row(
//             children: [
//               Icon(Icons.photo),
//               SizedBox(width: 8.0),
//               Text('Gallery'),
//             ],
//           ),
//           onPressed: () async {
//             final XFile? image = await ImagePicker().pickImage(
//               source: ImageSource.gallery,
//             );
//             if (image != null) {
//               selectedFile(image);
//             }
//             Navigator.pop(context, 'gallery');
//           },
//         ),
//         SimpleDialogOption(
//           child: Row(
//             children: [
//               Icon(Icons.camera),
//               SizedBox(width: 8.0),
//               Text('Camera'),
//             ],
//           ),
//           onPressed: () async {
//             final XFile? image = await ImagePicker().pickImage(
//               source: ImageSource.camera,
//             );
//             if (image != null) {
//               selectedFile(image);
//             }
//             Navigator.pop(context, 'gallery');
//           },
//         ),
//       ],
//     ),
//   );

  // showDialog(
  //   context: context,
  //   builder: (context) => AlertDialog(
  //     title: Text('Select Image Source'),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         ListTile(
  //           leading: Icon(Icons.photo),
  //           title: Text('Gallery'),
  //           onTap: () async {
  //             // final XFile? image = await ImagePicker().pickImage(
  //             //   source: ImageSource.gallery,
  //             // );
  //             // if (image != null) {
  //             //   final bytes = await image.readAsBytes();
  //             //   setState(() {
  //             //     _imageBytes = bytes;
  //             //   });
  //             // }
  //           },
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.camera),
  //           title: Text('Camera'),
  //           onTap: () async {
  //             // final XFile? image = await ImagePicker().pickImage(
  //             //   source: ImageSource.camera,
  //             // );
  //             // if (image != null) {
  //             //   final bytes = await image.readAsBytes();
  //             //   setState(() {
  //             //     _imageBytes = bytes;
  //             //   });
  //             // }
  //           },
  //         ),
  //       ],
  //     ),
  //   ),
  // );
// }
