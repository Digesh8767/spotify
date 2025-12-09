import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80),
        backgroundColor: Colors.green,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      child: Text(title, style: const TextStyle(color: Colors.white)),
    );
  }
}
