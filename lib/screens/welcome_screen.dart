import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_task_management_mobile_app/core/services/shared_preferences_manager.dart';
import 'package:tasky_task_management_mobile_app/core/widgets/custom_text_form_field.dart';
import 'package:tasky_task_management_mobile_app/screens/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _saveFullName() async {
    final username = _usernameController.text.trim();
    if (username.isNotEmpty) {
      // Save the username to shared preferences or any other storage
      // For example, using shared_preferences package:
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('username', username);
      await SharedPreferencesManager().setString('username', username);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 42,
                      height: 42,
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Tasky',
                      style: Theme.of(context).textTheme.displayMedium,
                      textHeightBehavior: const TextHeightBehavior(
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 108),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Welcome To Tasky',
                        style: Theme.of(context).textTheme.displaySmall,
                        overflow: TextOverflow.ellipsis,
                        textHeightBehavior: const TextHeightBehavior(
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/images/waving_hand.svg',
                      width: 28,
                      height: 28,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Your productivity journey starts here.',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 16),
                ),
                SizedBox(height: 24),
                SvgPicture.asset(
                  'assets/images/hero_image.svg',
                  width: 215,
                  height: 204.39,
                ),
                SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      CustomTextFormField(
                        title: 'User Name',
                        controller: _usernameController,
                        hintText: 'e.g. Abdelaaiz Ouakala',
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your user name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        MediaQuery.of(context).size.width - 32,
                        40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      'Let’s Get Started',
                      style: TextStyle(
                        color: Color(0XFFFFFCFC),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.1,
                        height: 1.42,
                      ),
                    ),
                    onPressed: () async {
                      // Navigate to the next screen or perform any action
                      if (_formKey.currentState!.validate()) {
                        // You can pass the full name to the next screen if needed
                        await _saveFullName(); // Save the full name to shared preferences
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      } else {
                        // Show an error message or prompt the user to enter their name
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter your full name'),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
