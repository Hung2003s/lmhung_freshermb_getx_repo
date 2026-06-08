import 'package:flutter/material.dart';
import 'dart:math' as math;
/// Class wrap gradient animation border bọc bên ngoài các widget
class GradientBorderAnimation extends StatefulWidget {
  final Widget child;
  const GradientBorderAnimation({super.key, required this.child});

  @override
  State<GradientBorderAnimation> createState() =>
      _GradientBorderAnimationState();
}

class _GradientBorderAnimationState extends State<GradientBorderAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final RotatingBorderPainter _painter;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _painter = RotatingBorderPainter(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: Padding(padding: const EdgeInsets.all(2.0), child: widget.child),
    );
  }
}

class RotatingBorderPainter extends CustomPainter {
  final Animation<double> animation;

  RotatingBorderPainter(this.animation) : super(repaint: animation);

  // Cache Paint object — tránh tạo mới mỗi frame
  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  // Cache gradient colors — const list, chỉ tạo 1 lần
  static const List<Color> _gradientColors = [
    Color(0xFF00C6FF),
    Color(0xFF103ABB),
    Color(0xFF8A2387),
    Color(0xFF00C6FF),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final progress = animation.value;

    final sweepGradient = SweepGradient(
      startAngle: 0,
      endAngle: math.pi * 2,
      colors: _gradientColors,
      transform: GradientRotation(progress * 2 * math.pi),
    );

    _paint.shader = sweepGradient.createShader(rect);

    final rRect = RRect.fromRectAndRadius(
      rect.deflate(3),
      const Radius.circular(16),
    );

    canvas.drawRRect(rRect, _paint);
  }

  @override
  bool shouldRepaint(covariant RotatingBorderPainter oldDelegate) {
    return oldDelegate.animation.value != animation.value;
  }
}
