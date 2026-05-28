import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool showIcon;

  const RoundedButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isLoading = false,
    this.icon = Icons.arrow_forward_rounded,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return OutlinedButton(
      // Nếu đang loading thì chặn không cho bấm tiếp
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        side: BorderSide(
          color: isDark
              ? const Color(0xFF333333)
              : Colors.grey.withValues(alpha: 0.3),
          width: 1.0,
        ),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        foregroundColor: theme.colorScheme.onSurface,
        disabledBackgroundColor: isDark
            ? const Color(0xFF161616)
            : Colors.grey.withValues(alpha: 0.1),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  if (showIcon && icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(
                      icon,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      size: 16,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
