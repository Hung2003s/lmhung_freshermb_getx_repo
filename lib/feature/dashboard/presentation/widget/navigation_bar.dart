import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../gen/colors.gen.dart';
import '../dashboard_controller.dart';

class CustomFloatingNavBar extends GetView<DashboardController> {
  const CustomFloatingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 16.0),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF111417) : Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              width: 2
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(index: 0, icon: Icons.home, isSelectedBgCircle: true),
              _buildNavItem(index: 1, icon: Icons.grid_view_rounded),
              _buildCenterSearchItem(index: 2),
              _buildNavItem(index: 3, icon: Icons.favorite_border_rounded),
              _buildNavItem(index: 4, icon: Icons.person_outline_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    bool isSelectedBgCircle = true,
  }) {
    final theme = Theme.of(Get.context!);
    final isDark = theme.brightness == Brightness.dark;
    return Obx(() {
      final isSelected = controller.currentTabIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeTab(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isSelected && isSelectedBgCircle
                ? (isDark ? Colors.white : Colors.black)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 26,
            color: isSelected
                ? (isSelectedBgCircle
                    ? (isDark ? Colors.black : Colors.white)
                    : theme.colorScheme.onSurface)
                : theme.colorScheme.onSurface.withValues(alpha: 0.4),
          ),
        ),
      );
    });
  }

  Widget _buildCenterSearchItem({required int index}) {
    final theme = Theme.of(Get.context!);
    final isDark = theme.brightness == Brightness.dark;
    return Obx(() {
      final isSelected = controller.currentTabIndex.value == index;

      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: ColorName.orange,
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark ? const Color(0xFF111417) : Colors.white,
              width: 3,
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: ColorName.orange.withValues(alpha: 0.4),
                blurRadius: 12,
                spreadRadius: 2,
              )
            ] : null,
          ),
          child: const Icon(
            Icons.search_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      );
    });
  }
}