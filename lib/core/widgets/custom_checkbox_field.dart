import 'package:flutter/material.dart';

class CustomCheckboxField extends StatelessWidget {
  final bool? value;
  final Function(bool? value) onChanged;
  const CustomCheckboxField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Color(0xFF15B86C),
      value: value,

      onChanged: (bool? value) => onChanged(value),
    );
  }
}
