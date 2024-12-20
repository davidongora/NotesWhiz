import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
    required this.buttonText,
    this.buttonIcon,
    this.onPressed,
  });

  final String buttonText;
  final IconData? buttonIcon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null
            ? Colors.blue.shade200
            : Colors.blue, // Faded color when disabled
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
      ),
      onPressed: onPressed,
      child: buttonIcon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  buttonText,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(width: 36),
                Icon(buttonIcon, color: Colors.white),
              ],
            )
          : Text(
              buttonText,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
    );
  }
}
