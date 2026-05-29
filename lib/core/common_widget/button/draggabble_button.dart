import 'package:flutter/material.dart';

class DraggableFloatingButton extends StatefulWidget {
  final Widget child;
  final Offset initialOffset;
  final Rect?
  boundaryRect; // Giới hạn không gian hoạt động (nếu null sẽ lấy toàn màn hình)

  const DraggableFloatingButton({
    super.key,
    required this.child,
    required this.initialOffset,
    this.boundaryRect,
  });

  @override
  State<DraggableFloatingButton> createState() =>
      _DraggableFloatingButtonState();
}

class _DraggableFloatingButtonState extends State<DraggableFloatingButton> {
  late Offset _position;
  bool _isDragging = false;
  final GlobalKey _key = GlobalKey();
  Size _widgetSize = const Size(
    56,
    56,
  ); // Kích thước mặc định ước lượng của FAB

  @override
  void initState() {
    super.initState();
    _position = widget.initialOffset;

    // Lấy kích thước thật của widget sau khi render frame đầu tiên
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_key.currentContext != null) {
        setState(() {
          _widgetSize =
              (_key.currentContext!.findRenderObject() as RenderBox).size;
          _snapToEdge(); // Đảm bảo vị trí ban đầu cũng nằm sát lề
        });
      }
    });
  }

  void _snapToEdge() {
    final Size screenSize = MediaQuery.of(context).size;
    final EdgeInsets padding = MediaQuery.of(context).padding;

    // Xác định không gian hoạt động
    final double minX = widget.boundaryRect?.right ?? 0;
    final double maxX =
        (widget.boundaryRect?.left ?? screenSize.width) - _widgetSize.width;
    final double minY = (widget.boundaryRect?.bottom ?? padding.bottom) + 100;
    final double maxY =
        (widget.boundaryRect?.top ?? screenSize.height) +
        _widgetSize.height +
        padding.top;

    // Tính toán lề trái hoặc phải gần nhất
    final double distanceToLeft = _position.dx - minX - 20;
    final double distanceToRight = maxX - _position.dx;

    setState(() {
      _isDragging = false;
      // Hút về bên nào gần hơn
      double snapX = (distanceToLeft < distanceToRight) ? minX : maxX;

      // Đảm bảo Y không lọt ra ngoài màn hình
      double snapY = _position.dy.clamp(minY, maxY);

      _position = Offset(snapX, snapY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      // Khi đang kéo thì duration = 0 để đi theo ngón tay ngay lập tức
      // Khi thả ra thì duration = 300ms để tạo animation trượt về lề
      duration: _isDragging ? Duration.zero : const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      right: _position.dx,
      bottom: _position.dy,
      child: GestureDetector(
        key: _key,
        onPanStart: (details) {
          setState(() {
            _isDragging = true;
          });
        },
        onPanUpdate: (details) {
          final Size screenSize = MediaQuery.of(context).size;
          final EdgeInsets padding = MediaQuery.of(context).padding;

          // Giới hạn Y tối đa (Cách top 100px)
          final double maxBottom = screenSize.height - 150 - _widgetSize.height;
          // Giới hạn Y tối thiểu (Sát mép dưới màn hình)
          final double minBottom = padding.bottom + 80;
          setState(() {
            // Tính toán vị trí mới
            Offset newPosition = _position - details.delta;

            // KHÓA TRỤC Y: Nếu kéo vượt quá giới hạn thì ghim lại tọa độ
            double clampedy = newPosition.dy.clamp(minBottom, maxBottom);
            // Cập nhật vị trí (Trục X vẫn thả rông đi theo tay, Trục Y bị khóa nếu chạm đỉnh/đáy)
            _position = Offset(newPosition.dx, clampedy);
          });
        },
        onPanEnd: (details) {
          _snapToEdge();
        },
        child: widget.child,
      ),
    );
  }
}
