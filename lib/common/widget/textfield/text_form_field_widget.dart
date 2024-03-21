
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.prefixIcon,
    this.validator,
    this.maxLength,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Widget prefixIcon;
  final String labelText;
  final String? Function(String?)? validator;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
      ),
    );
  }
}
