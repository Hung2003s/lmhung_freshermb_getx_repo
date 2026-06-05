import 'package:did_change_authlocal/did_change_authlocal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/constants/constants.dart';
import 'package:lmhung_freshermb_getx_repo/core/localization/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/biometric/biometric_auth_service.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/biometric/did_change_authlocal_service.dart';

import 'package:lmhung_freshermb_getx_repo/feature/auth/domain/usecases/logout_use_case.dart';

import '../../../core/navigation/routes.dart';
import '../../../core/utils/app_toast.dart';

class SettingController extends GetxController {
  final LogoutUseCase _logoutUseCase;

  SettingController(this._logoutUseCase);

  final GetStorage _storage = Get.find<GetStorage>();
  final BiometricAuthService _biometricAuth = BiometricAuthService();
  final DidChangeAuthLocalService _didChangeAuthLocal =
      DidChangeAuthLocalService();

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

  /// Bật xác thực sinh trắc học với quy trình bảo mật:
  ///
  /// Bước 1: Kiểm tra thay đổi (did_change_authlocal)
  /// Bước 2: Nếu thay đổi → chặn, yêu cầu xác thực lại
  ///         Nếu không thay đổi → Bước 3
  /// Bước 3: Xác thực người dùng (local_auth) để bật tính năng
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
          title: LocaleKeys.biometricEnableFailed.tr,
          message: LocaleKeys.biometricEnableFromLogin.tr,
        );
        return;
      }

      // ── Bước 1: Kiểm tra thay đổi sinh trắc học ──
      final savedToken = _storage.read<String>(Constants.biometricTokenKey);
      final status = await _didChangeAuthLocal.checkBiometricChanged(
        savedToken: savedToken,
      );

      // ── Bước 2: Xử lý rẽ nhánh ──
      if (status == AuthLocalStatus.changed) {
        // Trường hợp A: Phát hiện thay đổi → chặn
        AppToast.showError(
          title: LocaleKeys.biometricEnableFailed.tr,
          message: LocaleKeys.biometricChangedWarning.tr,
        );
        return;
      }

      if (status == AuthLocalStatus.invalid) {
        AppToast.showError(
          title: LocaleKeys.biometricEnableFailed.tr,
          message: LocaleKeys.biometricError.tr,
        );
        return;
      }

      // Trường hợp B: Không có thay đổi → an toàn, tiếp tục Bước 3

      // ── Bước 3: Xác thực vân tay để bật ──
      final authenticated = await _biometricAuth.authenticate(
        reason: LocaleKeys.biometricSaveReason.tr,
      );
      if (!authenticated) {
        return; // User cancel hoặc lỗi, không cần thông báo
      }

      // Lưu flag riêng biệt thay vì dựa vào credentials
      await _storage.write(Constants.biometricEnabledKey, true);

      // Lưu token mới để dùng cho lần kiểm tra sau
      await _saveBiometricToken();

      isBiometricEnabled.value = true;
      AppToast.showSuccess(title: LocaleKeys.biometricEnabled.tr);
    } finally {}
  }

  /// Lưu token sinh trắc học để dùng cho lần kiểm tra thay đổi sau này.
  Future<void> _saveBiometricToken() async {
    try {
      final token = await _didChangeAuthLocal.getCurrentToken();
      await _storage.write(Constants.biometricTokenKey, token);
    } catch (_) {
      // Lưu token thất bại, không critical
    }
  }

  /// Disable biometric login
  Future<void> disableBiometric() async {
    await _storage.remove(Constants.biometricEnabledKey);
    isBiometricEnabled.value = false;
    AppToast.showSuccess(title: LocaleKeys.biometricDisabled.tr);
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
      await _logoutUseCase();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      AppToast.showError(
        title: LocaleKeys.errorTitle.tr,
        message: LocaleKeys.logoutFailed.tr,
      );
    }
  }
}
