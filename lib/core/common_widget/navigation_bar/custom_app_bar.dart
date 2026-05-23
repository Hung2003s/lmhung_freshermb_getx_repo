import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/button/selected_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;                // Tiêu đề dạng String
  final Widget? titleWidget;          // Nếu muốn truyền custom Widget làm tiêu đề (vd: hình ảnh, thanh tìm kiếm)
  final bool centerTitle;             // Căn giữa tiêu đề hay không
  final List<Widget>? actions;        // Các nút hành động bên phải
  final Widget? leading;              // Nút bên trái (thường là nút Back hoặc Menu)
  final bool showBackButton;          // Có tự động hiển thị nút Back hay không
  final Color? backgroundColor;       // Màu nền của AppBar
  final Color? iconColor;              // Màu của icon nút back/leading
  final double? elevation;            // Độ đổ bóng
  final PreferredSizeWidget? bottom;   // Thanh phụ bên dưới (vd: TabBar)

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,          // Mặc định luôn căn giữa tiêu đề
    this.actions,
    this.leading,
    this.showBackButton = true,       // Mặc định luôn hiện nút Back nếu có thể quay lại
    this.backgroundColor, // Mặc định sẽ dùng theme color scheme
    this.iconColor, // Mặc định sẽ dùng theme color scheme
    this.elevation = 0,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBgColor = backgroundColor ?? theme.colorScheme.primary;
    final effectiveIconColor = iconColor ?? theme.colorScheme.onPrimary;
    final effectiveTitleColor = theme.colorScheme.onPrimary;

    return AppBar(
      backgroundColor: effectiveBgColor,
      elevation: elevation,
      centerTitle: centerTitle,
      iconTheme: IconThemeData(color: effectiveIconColor),

      // 1. Xử lý nút Leading (Bên trái)
      leading: leading ?? (showBackButton && Navigator.canPop(context)
          ? SelectedWidget(
        child:  Container(
          padding: EdgeInsetsGeometry.all(8),
          margin: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: effectiveIconColor.withValues(alpha: 0.1),
              border: Border.all(
                color: effectiveIconColor.withValues(alpha: 0.2),
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back_ios_new, size: 20, color: effectiveIconColor,)), // Icon back đẹp hơn mặc định
        onTap: () => Get.back(), // Dùng Get.back() đồng bộ với hệ thống GetX của bạn
      )
          : null),

      // 2. Xử lý Title (Ưu tiên titleWidget trước, nếu không có mới dùng String title)
      title: titleWidget ?? (title != null
          ? Text(
        title!,
        style: TextStyle(
          color: effectiveTitleColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      )
          : null),

      // 3. Xử lý các Actions (Bên phải)
      actions: actions,

      // 4. Xử lý Bottom
      bottom: bottom,
    );
  }

  // BẮT BUỘC PHẢI CÓ KHI IMPLEMENTS PreferredSizeWidget
  // Định nghĩa chiều cao mặc định cho AppBar của bạn (Kích thước chuẩn là kToolbarHeight = 56.0)
  @override
  Size get preferredSize => Size.fromHeight(
    bottom == null ? kToolbarHeight : kToolbarHeight + bottom!.preferredSize.height,
  );
}