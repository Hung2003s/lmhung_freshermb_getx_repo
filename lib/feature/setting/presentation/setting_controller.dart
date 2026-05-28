import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/constants/constants.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/biometric/biometric_auth_service.dart';
import 'package:lmhung_freshermb_getx_repo/navigation/routes.dart';

import '../../../core/storage/secure_storage/token/token_manager.dart';
import '../../../core/utils/app_toast.dart';

class SettingController extends GetxController {
  final GetStorage _storage = Get.find<GetStorage>();
  final BiometricAuthService _biometricAuth = BiometricAuthService();

  // Theme mode
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  // Language
  final Rx<Locale> currentLocale = const Locale('vi', 'VN').obs;

  // Biometric
  final RxBool isBiometricAvailable = false.obs;
  final RxBool isBiometricEnabled = false.obs;
  final RxString biometricTypeName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    Future.microtask(() => _loadSavedSettings());
    Future.microtask(() => _initBiometric());
  }

  Future<void> _initBiometric() async {
    final available = await _biometricAuth.isBiometricAvailable();
    isBiometricAvailable.value = available;
    if (available) {
      biometricTypeName.value = await _biometricAuth.getBiometricDisplayName();
      // Kiểm tra flag riêng biệt, không dựa vào sự tồn tại của credentials
      isBiometricEnabled.value =
          _storage.read<bool>(Constants.biometricEnabledKey) == true;
    }
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

  /// Bật xác thực sinh trắc học
  Future<void> enableBiometric() async {
    try {
      // Kiểm tra xem đã có credentials được lưu từ màn login chưa
      final savedUsername = _storage.read<String>(
        Constants.biometricUsernameKey,
      );
      final isRealCredentials =
          savedUsername != null &&
          savedUsername.isNotEmpty &&
          savedUsername != 'enabled';

      if (!isRealCredentials) {
        AppToast.showError(
          title: 'biometric_enable_failed'.tr,
          message: 'biometric_enable_from_login'.tr,
        );
        return;
      }

      // Xác thực vân tay để bật
      final authenticated = await _biometricAuth.authenticate(
        reason: 'biometric_save_reason'.tr,
      );
      if (!authenticated) {
        return; // User cancel hoặc lỗi, không cần thông báo
      }

      // Lưu flag riêng biệt thay vì dựa vào credentials
      await _storage.write(Constants.biometricEnabledKey, true);
      isBiometricEnabled.value = true;
      AppToast.showSuccess(title: 'biometric_enabled'.tr);
    } finally {
    }
  }

  /// Disable biometric login
  Future<void> disableBiometric() async {
    await _storage.remove(Constants.biometricEnabledKey);
    isBiometricEnabled.value = false;
    AppToast.showSuccess(title: 'biometric_disabled'.tr);
  }

  /// Toggle biometric on/off
  Future<void> toggleBiometric() async {
    if (isBiometricEnabled.value) {
      await disableBiometric();
    } else {
      await enableBiometric();
    }
  }

  Future<void> logout() async {
    try {
      await Get.find<TokenManager>().clearToken();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      AppToast.showError(title: 'error_title'.tr, message: 'logout_failed'.tr);
    }
  }
}
