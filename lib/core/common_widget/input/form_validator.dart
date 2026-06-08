import '../../enum/locale_keys.dart';

/// Reusable form validation utilities for common input fields.
/// These validators are designed to be used at the base widget layer.
class FormValidator {
  FormValidator._();

  /// Validates username/email for common rules.
  /// Returns an error message string if invalid, or null if valid.
  static String? validateUsername(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return LocaleKeys.usernameRequired.tr;
    }
    if (text.length < 3) {
      return LocaleKeys.usernameMinLength.tr;
    }
    if (text.length > 50) {
      return LocaleKeys.usernameMaxLength.tr;
    }
    return null;
  }

  /// Validates password for common rules.
  /// Returns an error message string if invalid, or null if valid.
  static String? validatePassword(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return LocaleKeys.passwordRequired.tr;
    }
    if (text.length < 6) {
      return LocaleKeys.passwordMinLength.tr;
    }
    if (text.length > 100) {
      return LocaleKeys.passwordMaxLength.tr;
    }
    return null;
  }
}
