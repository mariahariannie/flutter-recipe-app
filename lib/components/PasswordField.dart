import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final VoidCallback onTap;
  final TextEditingController controller;

  const PasswordField(
    {super.key,
    required this.labelText, 
    required this.hintText, 
    required this.obscureText, 
    required this.onTap,
    required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        prefix: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: const Icon(
            Icons.lock,
            color: Colors.red,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.red,
          ),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))
        )
      ),
    );
  }
}