import 'package:get/get.dart';

/// Reusable form validation utilities for common input fields.
/// These validators are designed to be used at the base widget layer.
class FormValidator {
  FormValidator._();

  /// Validates username/email for common rules.
  /// Returns an error message string if invalid, or null if valid.
  static String? validateUsername(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'username_required'.tr;
    }
    if (text.length < 3) {
      return 'username_min_length'.tr;
    }
    if (text.length > 50) {
      return 'username_max_length'.tr;
    }
    return null;
  }

  /// Validates password for common rules.
  /// Returns an error message string if invalid, or null if valid.
  static String? validatePassword(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'password_required'.tr;
    }
    if (text.length < 6) {
      return 'password_min_length'.tr;
    }
    if (text.length > 100) {
      return 'password_max_length'.tr;
    }
    // Check for at least 1 uppercase, 1 lowercase, 1 digit
    // (optional strictness – uncomment if needed)
    // if (!RegExp(r'(?=.*[A-Z])').hasMatch(text)) {
    //   return 'password_uppercase'.tr;
    // }
    // if (!RegExp(r'(?=.*[a-z])').hasMatch(text)) {
    //   return 'password_lowercase'.tr;
    // }
    // if (!RegExp(r'(?=.*\d)').hasMatch(text)) {
    //   return 'password_digit'.tr;
    // }
    return null;
  }
}
