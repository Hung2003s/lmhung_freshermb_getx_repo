import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import '../../../../gen/colors.gen.dart'; // Import file màu hệ thống của bạn

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String? greetingText;
  final VoidCallback? onNotificationPressed;
  final bool hasNotification;
  final Color backgroundColor;

  const ProfileAppBar({
    super.key,
    required this.username,
    this.greetingText,
    this.onNotificationPressed,
    this.hasNotification = true,
    this.backgroundColor = const Color(0xFF111417),
  });

  String _getGreeting() {
    if (greetingText != null) return greetingText!;
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Chào buổi sáng,';
    if (hour < 18) return 'Chào buổi chiều,';
    return 'Chào buổi tối,';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorName.orange.withValues(alpha: 0.3),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ColorName.orange,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ColorName.orange.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getGreeting(),
                  style: TextStyle(
                    color: context.theme.colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  username,
                  style: TextStyle(
                    color: context.theme.colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: onNotificationPressed,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color:  context.theme.colorScheme.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.05),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.notifications_none_rounded,
                    color: context.theme.colorScheme.surface,
                    size: 22,
                  ),
                ),
                if (hasNotification)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: ColorName.orange,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF111417),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(76);
}