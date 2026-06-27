import 'package:flutter/material.dart';
import 'package:tasky_task_management_mobile_app/core/services/shared_preferences_manager.dart';
import 'package:tasky_task_management_mobile_app/core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  final String username;
  final String motivationQuote;
  const UserDetailsScreen({
    super.key,
    required this.username,
    required this.motivationQuote,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController motivationQuoteController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    userNameController.text = widget.username;
    motivationQuoteController.text = widget.motivationQuote;
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    motivationQuoteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Details',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formState,
          child: Column(
            children: [
              CustomTextFormField(
                title: 'User Name',
                controller: userNameController,
                hintText: 'Enter your user name',
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your user name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              CustomTextFormField(
                title: 'Motivation Quote',
                controller: motivationQuoteController,
                hintText: 'enter your motivation quote',
                maxLines: 5,
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formState.currentState?.validate() ?? false) {
                    //final preferences = await SharedPreferences.getInstance();
                    await SharedPreferencesManager().setString(
                      'username',
                      userNameController.value.text,
                    );

                    await SharedPreferencesManager().setString(
                      'motivationQuote',
                      motivationQuoteController.value.text,
                    );
                    // Navigator.of(context).pop(true);
                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width - 32, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                icon: Icon(Icons.add),
                label: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
