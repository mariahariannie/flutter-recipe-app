import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SecondaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Colors.red
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16
            ),
          )
        ],
      )
    );
  }
}