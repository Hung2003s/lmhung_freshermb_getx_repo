import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageService extends GetxService {
  final GetStorage _box = GetStorage();

  // --- QUẢN LÝ THEME ---
  final String _themeKey = 'isDarkMode';

  bool get isDarkMode => _box.read(_themeKey) ?? false;

  void toggleTheme() {
    bool currentTheme = isDarkMode;
    // Lưu trạng thái đảo ngược
    _box.write(_themeKey, !currentTheme);
    // Yêu cầu GetX đổi theme ngay lập tức
    Get.changeThemeMode(!currentTheme ? ThemeMode.dark : ThemeMode.light);
  }

  // --- QUẢN LÝ NGÔN NGỮ ---
  final String _langKey = 'languageCode';

  String get languageCode => _box.read(_langKey) ?? 'vi';

  void saveLanguage(String langCode) {
    _box.write(_langKey, langCode);
    // Ví dụ: Get.updateLocale(Locale(langCode));
  }

  // --- XÓA DỮ LIỆU (Khi đăng xuất) ---
  void clearAllSettings() {
    _box.erase();
  }
}
