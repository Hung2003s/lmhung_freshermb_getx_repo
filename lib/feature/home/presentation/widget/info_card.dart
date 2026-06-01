import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/gen/colors.gen.dart';


class InfoCard extends StatelessWidget {
  final Widget icon;
  final Color iconColor;
  final bool hasGrow;

  const InfoCard({
    super.key,
    required this.icon,
    required this.iconColor,
    this.hasGrow = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : const Color(0xFFB0C4D8).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCardHeader(
            icon: icon,
            iconColor: iconColor,
            hasGrow: hasGrow,
          ),
          const SizedBox(height: 16),
          _buildInfoCardText(context),
        ],
      ),
    );
  }

  Widget _buildInfoCardHeader({
    required Widget icon,
    required Color iconColor,
    required bool hasGrow,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoIcon(icon: icon, iconColor: iconColor),
        if (hasGrow) _buildGrowBadge(),
      ],
    );
  }

  Widget _buildInfoIcon({required Widget icon, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withValues(alpha: 0.4), width: 2),
      ),
      child: icon,
    );
  }

  Widget _buildInfoCardText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('total_products'.tr, style: context.textTheme.titleSmall),
        const SizedBox(height: 2),
        Text('1200', style: context.textTheme.headlineSmall),
      ],
    );
  }

  Widget _buildGrowBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: ColorName.greenLight.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorName.greenLight.withValues(alpha: 0.6),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.icons.growUp.svg(),
          const SizedBox(width: 2),
          Text(
            'growing_percent'.tr,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ColorName.greenLight,
            ),
          ),
        ],
      ),
    );
  }
}
