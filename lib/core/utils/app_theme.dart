import 'package:flutter/material.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';

class AppTheme {
  // Tránh khởi tạo instance của class này
  AppTheme._();

  // Cấu hình cho Light Mode
  static final ThemeData lightTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      // Cấu hình màu cho hint text ở chế độ Sáng
      hintStyle: TextStyle(
        color: Colors.grey.withValues(alpha: 0.5), // Màu xám vừa phải cho hint
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: ColorName.orange,
      secondary: Colors.black,
      surface: ColorName.buttonBackground,
      onSurface: ColorName.gray, // Chữ trên nền surface
      error: ColorName.error,
    ),
    brightness: Brightness.light,
    primaryColor: ColorName.orange,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorName.orange,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorName.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textTheme: const TextTheme(
      // === DISPLAY (Dành cho số liệu lớn, banner, text nổi bật nhất) ===
      displayLarge: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.w700, // Bold
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),

      // === HEADLINE (Dành cho tiêu đề chính của màn hình) ===
      headlineLarge: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600, // Semi-bold
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),

      // === TITLE (Dành cho AppBar, tiêu đề phụ, tên danh sách) ===
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500, // Medium
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),

      // === BODY (Dành cho nội dung văn bản dài, mô tả) ===
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400, // Regular
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 16, // Kích thước phổ biến nhất cho text thường
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),

      // === LABEL (Dành cho text trong Button, Caption, chú thích nhỏ) ===
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        // Đậm hơn body một chút để nổi bật trong nút
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.black, // Nếu muốn chú thích mờ hơn, bạn có thể đổi thành Colors.black54 sau này
      ),
    ),
  );

  // Cấu hình cho Dark Mode (nếu có)
  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: ColorName.orange,
      secondary: Colors.white,
      surface: ColorName.darkBackground,
      onSurface: ColorName.gray, // Chữ trên nền surface
      error: ColorName.error,
    ),
    inputDecorationTheme: InputDecorationTheme(
      // Cấu hình màu cho hint text ở chế độ Sáng
      hintStyle: TextStyle(
        color: Colors.white.withValues(alpha: 0.6), // Màu xám vừa phải cho hint
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    brightness: Brightness.dark,
    primaryColor: ColorName.orange,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorName.orange,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorName.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    textTheme: const TextTheme(
      // === DISPLAY (Tiêu đề nổi bật nhất) ===
      displayLarge: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),

      // === HEADLINE (Tiêu đề chính) ===
      headlineLarge: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),

      // === TITLE (Tiêu đề phụ, AppBar) ===
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),

      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),

      // === LABEL (Text trong Button, Caption - Đã chuyển sang Trắng) ===
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors
            .white, // Tương tự, nếu muốn mờ hơn trên nền đen có thể dùng Colors.white70
      ),
    ),
  );
}
