import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/constants/constants.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/biometric/biometric_auth_service.dart';
import 'package:lmhung_freshermb_getx_repo/navigation/routes.dart';

import '../../../../core/utils/app_toast.dart';
import '../../data/models/login_model/login_model.dart';
import '../../domain/usecases/auth_usecase.dart';

class LoginController extends GetxController {
  final AuthUseCase _loginUseCase;
  final GetStorage _storage = Get.find<GetStorage>();
  final BiometricAuthService _biometricAuth = BiometricAuthService();

  LoginController(this._loginUseCase);

  var isLoading = false.obs;
  final errorMessage = ''.obs;

  // Login attempt limiter
  final RxInt loginAttemptCount = 0.obs;
  final RxBool isLocked = false.obs;
  final RxString lockoutMessage = ''.obs;

  // Biometric login
  final RxBool isBiometricAvailable = false.obs;
  final RxBool isBiometricEnabled = false.obs;
  final RxString biometricTypeName = ''.obs;

  //Bien trang thai ô nhập tên đăng nhập
  final userNameText = ''.obs;
  final TextEditingController userNameController = TextEditingController();
  late FocusNode userNameFocus;

  //Biển state ô nhập mật khẩu
  final passwordText = ''.obs;
  final TextEditingController passwordController = TextEditingController();
  late FocusNode passwordFocus;

  @override
  void onInit() {
    userNameFocus = FocusNode();
    passwordFocus = FocusNode();
    userNameController.addListener(() {
      userNameText.value = userNameController.text;
    });
    _checkLockoutStatus();
    _initBiometric();
    super.onInit();
  }

  Future<void> _initBiometric() async {
    final available = await _biometricAuth.isBiometricAvailable();
    isBiometricAvailable.value = available;
    if (available) {
      biometricTypeName.value = await _biometricAuth.getBiometricDisplayName();
      final savedUsername = _storage.read<String>(
        Constants.biometricUsernameKey,
      );
      final savedPassword = _storage.read<String>(
        Constants.biometricPasswordKey,
      );
      // Only consider if both username and password are real credentials
      isBiometricEnabled.value =
          savedUsername != null &&
          savedUsername.isNotEmpty &&
          savedUsername != 'enabled' &&
          savedPassword != null &&
          savedPassword.isNotEmpty &&
          savedPassword != 'enabled';
    }
  }

  void _checkLockoutStatus() {
    final lockoutTimeStr = _storage.read<String>(Constants.loginLockoutTimeKey);
    if (lockoutTimeStr != null) {
      final lockoutTime = DateTime.tryParse(lockoutTimeStr);
      if (lockoutTime != null && DateTime.now().isBefore(lockoutTime)) {
        // Still locked
        isLocked.value = true;
        final remainingMinutes =
            lockoutTime.difference(DateTime.now()).inMinutes + 1;
        lockoutMessage.value = 'login_locked'.trParams({
          's': remainingMinutes.toString(),
        });
        loginAttemptCount.value = Constants.maxLoginAttempts;
        return;
      } else {
        // Lockout expired, reset
        _resetLoginAttempts();
      }
    }

    // Load saved attempt count
    final savedCount = _storage.read<int>(Constants.loginAttemptCountKey);
    if (savedCount != null) {
      loginAttemptCount.value = savedCount;
    }
  }

  ///Reset lại các biến đếm số lần đăng nhập sai
  void _resetLoginAttempts() {
    loginAttemptCount.value = 0;
    isLocked.value = false;
    lockoutMessage.value = '';
    _storage.remove(Constants.loginAttemptCountKey);
    _storage.remove(Constants.loginLockoutTimeKey);
  }

  void _incrementAttemptCount() {
    loginAttemptCount.value++;
    _storage.write(Constants.loginAttemptCountKey, loginAttemptCount.value);

    if (loginAttemptCount.value >= Constants.maxLoginAttempts) {
      // Lock the account
      isLocked.value = true;
      final lockoutUntil = DateTime.now().add(
        Duration(seconds: Constants.lockoutDurationSeconds),
      );
      _storage.write(
        Constants.loginLockoutTimeKey,
        lockoutUntil.toIso8601String(),
      );

      final remainingSeconds = Constants.lockoutDurationSeconds;
      lockoutMessage.value = 'login_locked'.trParams({
        's': remainingSeconds.toString(),
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (userNameText.value.isNotEmpty) {
      passwordFocus.requestFocus();
    } else {
      userNameFocus.requestFocus();
    }
  }

  @override
  void onClose() {
    userNameController.dispose();
    userNameFocus.unfocus();
    passwordFocus.unfocus();
    userNameFocus.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    super.onClose();
  }

  Future<void> login() async {
    // Kiểm tra nếu bị lock
    if (isLocked.value) {
      AppToast.showError(
        title: 'login_locked_button'.tr,
        message: lockoutMessage.value,
      );
      return;
    }

    String username = userNameText.value.trim();
    String password = passwordText.value.trim();
    if (username.isEmpty || password.isEmpty) {
      AppToast.showError(
        title: 'login_failed'.tr,
        message: 'invalid_credentials'.tr,
      );
      return;
    }
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final request = LoginParams(userName: username, password: password);

      final response = await _loginUseCase(request);
      if (response.accessToken.isNotEmpty) {
        TextInput.finishAutofillContext(shouldSave: true);
        _resetLoginAttempts(); // Reset attempts on successful login
        await _saveBiometricCredentials(
          username,
          password,
        ); // Lưu thông tin xác thực sinh học
        Get.offAllNamed(Routes.dashboard);
        AppToast.showSuccess(
          title: 'login_success'.tr,
          message: errorMessage.value,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();

      // tăng số lần đăng nhập sai
      _incrementAttemptCount();

      if (isLocked.value) {
        AppToast.showError(
          title: 'login_locked_button'.tr,
          message: lockoutMessage.value,
        );
      } else {
        final attemptsLeft =
            Constants.maxLoginAttempts - loginAttemptCount.value;
        final subtitle = attemptsLeft > 0
            ? 'login_attempts_left'.trParams({'s': attemptsLeft.toString()})
            : errorMessage.value;
        AppToast.showError(title: 'login_failed'.tr, message: subtitle);
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Lưu thông tin đăng nhập và dữ liệu sinh học sau khi đăng nhập
  Future<void> _saveBiometricCredentials(
    String username,
    String password,
  ) async {
    await _storage.write(Constants.biometricUsernameKey, username);
    await _storage.write(Constants.biometricPasswordKey, password);
    isBiometricEnabled.value = true;
  }

  /// Đang nhap bang van tay
  Future<bool> loginWithBiometric() async {
    if (!isBiometricAvailable.value || !isBiometricEnabled.value) {
      return false;
    }

    try {
      final authenticated = await _biometricAuth.authenticate(
        reason: 'biometric_login_reason'.tr,
      );
      if (!authenticated) return false;

      // Lấy thông tin xác thực từ vân tay đã lưu
      final savedUsername =
          _storage.read<String>(Constants.biometricUsernameKey) ?? '';
      final savedPassword =
          _storage.read<String>(Constants.biometricPasswordKey) ?? '';

      if (savedUsername.isEmpty || savedPassword.isEmpty) {
        isBiometricEnabled.value = false;
        return false;
      }

      // đăng nhập bằng thông tin xác thực đã lưu
      try {
        isLoading.value = true;
        errorMessage.value = '';

        final request = LoginParams(
          userName: savedUsername,
          password: savedPassword,
        );
        final response = await _loginUseCase(request);
        if (response.accessToken.isNotEmpty) {
          _resetLoginAttempts();
          Get.offAllNamed(Routes.dashboard);
          AppToast.showSuccess(title: 'login_success'.tr);
          return true;
        }
      } catch (e) {
        errorMessage.value = e.toString();
        AppToast.showError(
          title: 'login_failed'.tr,
          message: 'biometric_login_failed_credentials'.tr,
        );
      } finally {
        isLoading.value = false;
      }
      return false;
    } on BiometricException catch (e) {
      if (e.message != 'biometric_canceled'.tr) {
        AppToast.showError(
          title: 'biometric_login_failed'.tr,
          message: e.message,
        );
      }
      return false;
    }
  }

  void navigateToRegister() {
    Get.toNamed(Routes.register);
  }
}
