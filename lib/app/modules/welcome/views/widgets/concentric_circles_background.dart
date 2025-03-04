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
          primaryColor: const Color(0xFFF15A38),
          secondaryColor: const Color(0xFFF47857),
        ),
      ),
    );
  }
}

class ConcentricCirclesPainter extends CustomPainter {
  /// Primary color for circles - typically used for odd-indexed circles
  final Color primaryColor;

  /// Secondary color for circles - typically used for even-indexed circles
  final Color secondaryColor;

  /// Number of concentric circles to draw
  final int circleCount;

  /// Center position of the circles
  /// If null, centers horizontally and at specified offsetY position vertically
  final Offset? center;

  /// Vertical position ratio (0.0 to 1.0) when using automatic horizontal centering
  /// 0.0 places the center at the top edge, 1.0 at the bottom edge, 0.5 in the middle
  final double offsetY;

  /// Maximum radius ratio compared to screen width
  /// 1.0 means the largest circle has a diameter equal to the screen width
  final double maxRadiusRatio;

  /// Whether to alternate colors between primary and secondary
  /// If false, you can use the colorBuilder function for custom color schemes
  final bool alternateColors;

  /// Optional function to build custom colors for each circle
  /// Index starts from 0 (innermost circle) to circleCount-1 (outermost)
  /// If null and alternateColors is true, will alternate between primaryColor and secondaryColor
  final Color Function(int index, int totalCount)? colorBuilder;

  /// Spacing between circles as a ratio of the total radius space
  /// 0.0 means no space (circles touch), 1.0 would mean only the outermost circle is visible
  final double spacingRatio;

  /// Optional list of opacities for each circle
  /// Should contain exactly circleCount values between 0.0 and 1.0
  /// If null, all circles will be fully opaque
  final List<double>? opacities;

  ConcentricCirclesPainter({
    required this.primaryColor,
    required this.secondaryColor,
    this.circleCount = 11,
    this.center,
    this.offsetY = 0.5,
    this.maxRadiusRatio = 1.2,
    this.alternateColors = true,
    this.colorBuilder,
    this.spacingRatio = 0.0,
    this.opacities,
  }) : assert(
          opacities == null || opacities.length == circleCount,
          'If provided, opacities list must have exactly $circleCount items',
        );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Determine the center point for the circles
    final centerPoint = center ?? Offset(size.width / 2, size.height * offsetY);

    // Calculate the maximum radius based on screen width and the maxRadiusRatio
    final maxRadius = size.width * maxRadiusRatio;

    // Calculate the radius reduction step
    final radiusStep = maxRadius / circleCount;

    // Start from the outermost circle and move inward
    for (int i = 0; i < circleCount; i++) {
      // Calculate the radius for this circle
      final radius = maxRadius - (i * radiusStep * (1.0 + spacingRatio));

      // Skip if radius becomes too small
      if (radius <= 0) continue;

      // Set the circle color based on options
      if (colorBuilder != null) {
        // Use the custom color builder
        paint.color = colorBuilder!(i, circleCount);
      } else if (alternateColors) {
        // Alternate between primary and secondary colors
        paint.color = i % 2 == 0 ? primaryColor : secondaryColor;
      } else {
        // Default to primary color
        paint.color = primaryColor;
      }

      // Apply opacity if provided
      if (opacities != null) {
        paint.color = paint.color.withValues(alpha: opacities![i]);
      }

      // Draw the circle
      canvas.drawCircle(centerPoint, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ConcentricCirclesPainter oldDelegate) {
    return false;
  }
}
