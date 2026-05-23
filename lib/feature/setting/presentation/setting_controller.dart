import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  // Theme mode
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  // Language
  final Rx<Locale> currentLocale = const Locale('vi', 'VN').obs;

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
  }

  void setLanguage(String languageCode) {
    final locale = Locale(languageCode, languageCode == 'vi' ? 'VN' : 'US');
    currentLocale.value = locale;
    Get.updateLocale(locale);
  }

  bool get isDarkMode => themeMode.value == ThemeMode.dark;
  bool get isLightMode => themeMode.value == ThemeMode.light;
  bool get isSystemMode => themeMode.value == ThemeMode.system;

  String get currentLanguageCode => currentLocale.value.languageCode;
}