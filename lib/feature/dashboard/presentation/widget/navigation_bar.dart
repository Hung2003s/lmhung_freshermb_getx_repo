import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../gen/colors.gen.dart';
import '../dashboard_controller.dart';

class CustomFloatingNavBar extends GetView<DashboardController> {
  const CustomFloatingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        // Đẩy khay menu cách đáy và 2 bên mép màn hình một khoảng để tạo hiệu ứng "nổi"
        padding: const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 16.0),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFF111417), // Màu nền xám đen tối như trong ảnh
            borderRadius: BorderRadius.circular(40), // Bo tròn dạng capsule hoàn toàn
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8), // Đổ bóng nhẹ xuống dưới
              ),
            ],
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 2
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Tab 0: Home
              _buildNavItem(index: 0, icon: Icons.home, isSelectedBgCircle: true),

              // Tab 1: Category
              _buildNavItem(index: 1, icon: Icons.grid_view_rounded),

              // Tab 2: Search (Nút chính giữa nổi bật)
              _buildCenterSearchItem(index: 2),

              // Tab 3: Wishlist
              _buildNavItem(index: 3, icon: Icons.favorite_border_rounded),

              // Tab 4: Profile
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
    bool isSelectedBgCircle = true  ,
  }) {
    return Obx(() {
      final isSelected = controller.currentTabIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeTab(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isSelected && isSelectedBgCircle ? Colors.white : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 26,
            color: isSelected
                ? (isSelectedBgCircle ? Colors.black : Colors.white)
                : Colors.grey.withOpacity(0.6),
          ),
        ),
      );
    });
  }

  Widget _buildCenterSearchItem({required int index}) {
    return Obx(() {
      final isSelected = controller.currentTabIndex.value == index;

      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color:  ColorName.orange,
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF111417),
              width: 3,
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: ColorName.orange.withValues(alpha: 0.4),
                blurRadius: 12,
                spreadRadius: 2, // Tạo hiệu ứng phát sáng nhẹ khi click chọn
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