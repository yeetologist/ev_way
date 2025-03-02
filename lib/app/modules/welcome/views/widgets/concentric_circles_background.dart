import 'package:flutter/material.dart';

class ConcentricCirclesBackground extends StatelessWidget {
  const ConcentricCirclesBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return // Background with concentric circles
        Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF15A38),
        borderRadius: BorderRadius.circular(24),
      ),
      child: CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: ConcentricCirclesPainter(
          baseColor: const Color(0xFFF15A38),
          lightColor: const Color(0xFFF47857),
        ),
      ),
    );
  }
}

class ConcentricCirclesPainter extends CustomPainter {
  final Color baseColor;
  final Color lightColor;

  ConcentricCirclesPainter({
    required this.baseColor,
    required this.lightColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Center point for the circles (slightly above center)
    final center = Offset(size.width / 2, size.height * 0.5);

    // Number of circles to draw
    const numberOfCircles = 11;

    // Start from the outermost circle and move inward
    for (int i = 0; i < numberOfCircles; i++) {
      // Calculate radius based on device width
      // Each circle gets smaller as i increases
      final radius = size.width * 1.2 - (i * (size.width / numberOfCircles));

      // Alternate between two shades of orange
      paint.color = i % 2 == 0 ? baseColor : lightColor;

      // Draw the circle
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
