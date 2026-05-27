import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../gen/colors.gen.dart';

class AppToast {
  static void _show({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    // Đảm bảo không bị trùng lặp nhiều snackbar trên màn hình
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      icon: Icon(icon, color: Colors.white, size: 28),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 200),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }


  /// Toast Báo lỗi (Màu Đỏ)
  static void showError({String title = 'Lỗi', required String message}) {
    _show(
      title: title,
      message: message,
      // Bạn có thể thay bằng ColorName.red của bạn
      backgroundColor: ColorName.error.withValues(alpha: 0.9),
      icon: Icons.error_outline,
    );
  }

  /// Toast Thành công (Màu Xanh)
  static void showSuccess({String title = 'Thành công', String? message}) {
    _show(
      title: title,
      message: message ?? '',
      // Sử dụng màu của bạn
      backgroundColor: ColorName.greenLight.withValues(alpha: 0.9),
      icon: Icons.check_circle_outline,
    );
  }

  /// Toast Cảnh báo (Màu Cam/Vàng)
  static void showWarning({
    String title = 'Cảnh báo',
    required String message,
  }) {
    _show(
      title: title,
      message: message,
      backgroundColor: Colors.orange.withValues(alpha: 0.9),
      icon: Icons.warning_amber_rounded,
    );
  }

  /// Toast Thông tin (Màu Xanh dương)
  static void showInfo({String title = 'Thông báo', required String message}) {
    _show(
      title: title,
      message: message,
      backgroundColor: Colors.blueAccent.withValues(alpha: 0.9),
      icon: Icons.info_outline,
    );
  }
}
