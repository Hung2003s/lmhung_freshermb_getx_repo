import 'dart:math';
import 'package:flutter/material.dart';
/// Class animation rung wrap vào widget con
class ShakeWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double deltaX; // khoảng cách rung

  const ShakeWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.deltaX = 4,
  });

  @override
  State<ShakeWidget> createState() => ShakeWidgetState();
}

// Custom một Curve hình sin để tạo hiệu ứng lắc qua lắc lại độc lập
class _SineCurve extends Curve {
  final double count; // Số lần lắc qua lắc lại
  const _SineCurve({this.count = 3});

  @override
  double transformInternal(double t) {
    return sin(t * count * 2 * pi);
  }
}

class ShakeWidgetState extends State<ShakeWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Hàm công khai để gọi kích hoạt rung
  void shake() {
    _controller.forward(from: 0.0); // Chạy animation từ đầu
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final sinValue = const _SineCurve(count: 3).transform(_controller.value);
        return Transform.translate(
          // Dịch chuyển widget theo trục X dựa trên sóng sin và deltaX
          offset: Offset(sinValue * widget.deltaX, 0),
          child: child,
        );
      },
    );
  }
}