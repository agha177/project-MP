// widgets/custom_button.dart
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.color = Colors.purple,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        textStyle: TextStyle(fontSize: 16),
      ),
    );
  }
}



class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade800,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}

