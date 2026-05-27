import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/constants/constants.dart';
import 'package:lmhung_freshermb_getx_repo/navigation/routes.dart';

import '../../../core/storage/secure_storage/token/token_manager.dart';
import '../../../core/utils/app_toast.dart';

class SettingController extends GetxController {
  final GetStorage _storage = Get.find<GetStorage>();

  // Theme mode
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  // Language
  final Rx<Locale> currentLocale = const Locale('vi', 'VN').obs;

  @override
  void onInit() {
    super.onInit();
    // Defer loading to avoid calling Get.changeThemeMode/Get.updateLocale during build
    Future.microtask(() => _loadSavedSettings());
  }

  void _loadSavedSettings() {
    // Load saved theme mode
    final savedThemeMode = _storage.read<String>(Constants.themeModeKey);
    if (savedThemeMode != null) {
      switch (savedThemeMode) {
        case 'light':
          themeMode.value = ThemeMode.light;
          break;
        case 'dark':
          themeMode.value = ThemeMode.dark;
          break;
        default:
          themeMode.value = ThemeMode.system;
      }
    }

    // Load saved language
    final savedLanguageCode = _storage.read<String>(Constants.languageCodeKey);
    if (savedLanguageCode != null) {
      currentLocale.value = Locale(
        savedLanguageCode,
        savedLanguageCode == 'vi' ? 'VN' : 'US',
      );
    }

    // Apply loaded settings
    Get.changeThemeMode(themeMode.value);
    Get.updateLocale(currentLocale.value);
  }

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);

    // Save to storage
    String modeString;
    switch (mode) {
      case ThemeMode.light:
        modeString = 'light';
        break;
      case ThemeMode.dark:
        modeString = 'dark';
        break;
      default:
        modeString = 'system';
    }
    _storage.write(Constants.themeModeKey, modeString);
  }

  void setLanguage(String languageCode) {
    final locale = Locale(languageCode, languageCode == 'vi' ? 'VN' : 'US');
    currentLocale.value = locale;
    Get.updateLocale(locale);

    // Save to storage
    _storage.write(Constants.languageCodeKey, languageCode);
  }

  bool get isDarkMode => themeMode.value == ThemeMode.dark;

  bool get isLightMode => themeMode.value == ThemeMode.light;

  bool get isSystemMode => themeMode.value == ThemeMode.system;

  String get currentLanguageCode => currentLocale.value.languageCode;

  Future<void> logout() async {
    try {
      await Get.find<TokenManager>().clearToken();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      AppToast.showError(title: 'error_title'.tr, message: 'logout_failed'.tr);
    }
  }
}
