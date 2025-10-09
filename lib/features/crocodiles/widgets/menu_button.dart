import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key, required this.text, required this.icon, required this.onPressed});

  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
