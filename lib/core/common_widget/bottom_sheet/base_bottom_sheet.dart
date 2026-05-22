import 'package:flutter/material.dart';

class BaseBottomSheet extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final double? height;
  final bool showCloseButton;

  const BaseBottomSheet({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.height,
    this.showCloseButton = true,
  });

  /// hien thi thanh cuon tu duoi len voi tieu de va noi dung
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget body,
    List<Widget>? actions,
    double? height,
    bool showCloseButton = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BaseBottomSheet(
        title: title,
        body: body,
        actions: actions,
        height: height,
        showCloseButton: showCloseButton,
      ),
    );
  }

  /// xay dung giao dien khung cua bottom sheet
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHandle(),
          _buildHeader(context),
          const Divider(height: 1),
          Expanded(child: body),
          if (actions != null && actions!.isNotEmpty) ...[
            const Divider(height: 1),
            _buildActions(),
          ],
        ],
      ),
    );
  }

  /// tao thanh cam de keo mo hoac dong bottom sheet
  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  /// tao phan dau trang bao gom tieu de va nut dong
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ),
          if (showCloseButton)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () {
                Navigator.pop(context);
              },
              splashColor: const Color(0x1F1A237E),
              highlightColor: const Color(0x141A237E),
            ),
        ],
      ),
    );
  }

  /// tao danh sach cac nut hanh dong o duoi cung
  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions!.map((widget) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: widget,
          );
        }).toList(),
      ),
    );
  }
}