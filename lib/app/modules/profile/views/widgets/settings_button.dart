import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final Color backgroundColor;

  const SettingsButton({
    super.key,
    required this.text,
    required this.icon,
    this.iconColor = const Color(0xFF2DC4BF), // Teal color for icon
    required this.onTap,
    this.backgroundColor = const Color(0xFFFFF5F5), // Light pink background
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: 28.0,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(text,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                Icon(
                  Icons.chevron_right,
                  color: iconColor,
                  size: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
