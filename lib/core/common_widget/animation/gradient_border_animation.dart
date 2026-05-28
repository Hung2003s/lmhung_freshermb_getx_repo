import 'package:flutter/material.dart';
import 'dart:math' as math;

class GradientBorderAnimation extends StatefulWidget {
  final Widget child;
  const GradientBorderAnimation({super.key, required this.child});

  @override
  State<GradientBorderAnimation> createState() =>
      _GradientBorderAnimationState();
}

class _GradientBorderAnimationState extends State<GradientBorderAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(); // Lặp vô hạn
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RotatingBorderPainter(_controller.value),
          child: Padding(padding: const EdgeInsets.all(2.0), child: child),
        );
      },
    );
  }
}

class RotatingBorderPainter extends CustomPainter {
  final double progress;
  RotatingBorderPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final sweepGradient = SweepGradient(
      startAngle: 0,
      endAngle: math.pi * 2,
      colors: const [
        // Colors.red,
        // Colors.orange,
        // Colors.yellow,
        // Colors.green,
        // Colors.blue,
        // Colors.purple,
        // Colors.red, // lặp lại để mượt
        Color(0xFF00C6FF),
        Color(0xFF103ABB),
        Color(0xFF8A2387), // Tím không gian
        Color(0xFF00C6FF),
      ],
      transform: GradientRotation(progress * 2 * math.pi),
    );

    final paint = Paint()
      ..shader = sweepGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final rRect = RRect.fromRectAndRadius(
      rect.deflate(3), // khoảng cách viền
      const Radius.circular(16),
    );

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant RotatingBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
