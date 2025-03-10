import 'package:flutter/material.dart';

class AboutListItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final Color arrowColor;

  const AboutListItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor = const Color(0xFF26BDB9), // Teal color for the icons
    this.arrowColor =
        const Color(0xFF26BDB9), // Teal color for the arrow button
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            spreadRadius: 0.5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Row(
              children: [
                // Left icon
                Icon(
                  icon,
                  color: iconColor,
                  size: 32.0,
                ),

                const SizedBox(width: 16.0),

                // Title text
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),

                // Right arrow button
                Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: arrowColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
