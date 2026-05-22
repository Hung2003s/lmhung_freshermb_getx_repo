import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widget/dialog/base_dialog.dart';

extension DialogX on GetInterface {

  Future<T?> showCustomDialog<T>({
    required String title,
    required Widget content,
    Widget? footer, // Nhận vào một Widget cho phần chân trang
    double? width,
    bool showCloseIcon = true,
    bool barrierDismissible = true,
  }) {
    return Get.dialog<T>(
      BaseDialog(
        title: title,
        content: content,
        footer: footer,
        width: width,
        showCloseIcon: showCloseIcon,
      ),
      barrierDismissible: barrierDismissible,
      transitionCurve: Curves.easeInOut,
    );
  }
}
