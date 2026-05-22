import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget? footer;
  final double? width;
  final bool showCloseIcon;

  const BaseDialog({
    super.key,
    required this.title,
    required this.content,
    this.footer,
    this.width,
    this.showCloseIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: const Color(0xFF1E1E1E),
      elevation: 5,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: width ?? (screenSize.width * 0.85),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10,),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (showCloseIcon)
                  IconButton( // Dùng IconButton để có hit test area tốt hơn
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF9E9E9E),
                      size: 22,
                    ),
                    onPressed: () {
                      // Navigator.of(context) ở đây CHẮC CHẮN là của Dialog
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Flexible(
              child: SingleChildScrollView(
                child: content,
              ),
            ),
            if (footer != null) ...[
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: footer!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
