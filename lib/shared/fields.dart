import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const InputField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator, // required Null Function() onChanged,
    errorText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        focusNode: focusNode,
        style: const TextStyle(
            color: Colors.white), // Set text input color to white
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: const TextStyle(
            color: Colors.blue, // Blue color for label
          ),
          hintStyle: const TextStyle(
            color: Colors.blue, // Light blue for hint text
          ),
          prefixIcon: prefixIcon != null
              ? IconTheme(
                  data: const IconThemeData(
                      color: Colors.white), // White color for prefix icon
                  child: prefixIcon!,
                )
              : null,
          suffixIcon: suffixIcon != null
              ? IconTheme(
                  data: const IconThemeData(
                      color: Colors.white), // White color for suffix icon
                  child: suffixIcon!,
                )
              : null,
          // filled: true, // Enable background color
          // fillColor: Colors.blue.shade700, // Dormant blue background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                BorderSide(color: Colors.blue.shade200), // Dormant blue border
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}
