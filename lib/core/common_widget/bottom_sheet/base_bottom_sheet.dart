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
    final theme = Theme.of(context);
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHandle(context),
          _buildHeader(context),
          Divider(height: 1, color: theme.dividerColor),
          Expanded(child: body),
          if (actions != null && actions!.isNotEmpty) ...[
            Divider(height: 1, color: theme.dividerColor),
            _buildActions(),
          ],
        ],
      ),
    );
  }

  /// tao thanh cam de keo mo hoac dong bottom sheet
  Widget _buildHandle(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  /// tao phan dau trang bao gom tieu de va nut dong
  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          if (showCloseButton)
            IconButton(
              icon: Icon(Icons.close, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
              onPressed: () {
                Navigator.pop(context);
              },
              splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              highlightColor: theme.colorScheme.primary.withValues(alpha: 0.05),
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