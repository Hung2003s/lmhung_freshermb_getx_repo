import 'package:flutter/material.dart';

import '../../gen/colors.gen.dart';
import '../../enum/locale_keys.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String? greetingText;
  final VoidCallback? onNotificationPressed;
  final bool hasNotification;
  final Color? backgroundColor;

  const ProfileAppBar({
    super.key,
    required this.username,
    this.greetingText,
    this.onNotificationPressed,
    this.hasNotification = true,
    this.backgroundColor,
  });

  String _getGreeting() {
    if (greetingText != null) return greetingText!;
    final hour = DateTime.now().hour;
    if (hour < 12) return LocaleKeys.greetingMorning.tr;
    if (hour < 18) return LocaleKeys.greetingAfternoon.tr;
    return LocaleKeys.greetingEvening.tr;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.scaffoldBackgroundColor;
    return AppBar(
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.3),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          userAvatar(theme),
          const SizedBox(width: 14),
          title(theme),
          notificationButton(theme, bgColor),
        ],
      ),
    );
  }

  Expanded title(ThemeData theme) {
    return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _getGreeting(),
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                username,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
  }

  GestureDetector notificationButton(ThemeData theme, Color bgColor) {
    return GestureDetector(
          onTap: onNotificationPressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: theme.colorScheme.primary,
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
                      color: ColorName.error,
                      shape: BoxShape.circle,
                      border: Border.all(color: bgColor, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
        );
  }

  Container userAvatar(ThemeData theme) {
    return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person_rounded,
            color: theme.colorScheme.onPrimary,
            size: 24,
          ),
        );
  }

  @override
  Size get preferredSize => const Size.fromHeight(76);
}
