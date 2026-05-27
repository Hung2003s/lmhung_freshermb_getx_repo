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
    return OutlinedButton(
      // Nếu đang loading thì chặn không cho bấm tiếp
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFF1E1E1E),
        side: const BorderSide(
          color: Color(0xFF333333),
          width: 1.0,
        ),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        foregroundColor: Colors.white10,
        disabledBackgroundColor: const Color(0xFF161616),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9E9E9E)),
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
            if (showIcon && icon != null) ...[
              const SizedBox(width: 8),
              Icon(
                icon,
                color: const Color(0xFF9E9E9E),
                size: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }
}