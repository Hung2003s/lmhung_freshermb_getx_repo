import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/constants/constants.dart';
import 'package:lmhung_freshermb_getx_repo/feature/setting/presentation/setting_controller.dart';

import '../../core/storage/secure_storage/token/token_manager.dart';
import '../../navigation/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _initApp();
  }

  Future<void> _initApp() async {
    // Load saved settings (theme & language) after build phase completes
    await Future.microtask(() => _loadSavedSettings());

    // Đợi TokenManager khởi tạo và đọc token từ storage
    final tokenManager = Get.find<TokenManager>();
    await tokenManager.init();

    // Chờ một chút cho hiệu ứng splash
    await Future.delayed(const Duration(milliseconds: 120));

    splashNavigate();
  }

  void _loadSavedSettings() {
    final storage = Get.find<GetStorage>();
    final settingController = Get.find<SettingController>();

    // Load saved theme mode
    final savedThemeMode = storage.read<String>(Constants.themeModeKey);
    if (savedThemeMode != null) {
      switch (savedThemeMode) {
        case 'light':
          settingController.themeMode.value = ThemeMode.light;
          break;
        case 'dark':
          settingController.themeMode.value = ThemeMode.dark;
          break;
        default:
          settingController.themeMode.value = ThemeMode.system;
      }
    }
    Get.changeThemeMode(settingController.themeMode.value);

    // Load saved language
    final savedLanguageCode = storage.read<String>(Constants.languageCodeKey);
    if (savedLanguageCode != null) {
      settingController.currentLocale.value = Locale(
        savedLanguageCode,
        savedLanguageCode == 'vi' ? 'VN' : 'US',
      );
    }
    Get.updateLocale(settingController.currentLocale.value);
  }

  void splashNavigate() {
    final tokenManager = Get.find<TokenManager>();

    // Kiểm tra token còn tồn tại và còn hạn hay không
    if (tokenManager.isTokenValid) {
      Get.offAllNamed(Routes.dashboard);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}