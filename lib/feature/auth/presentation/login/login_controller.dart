import 'package:did_change_authlocal/did_change_authlocal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/input/form_validator.dart';
import 'package:lmhung_freshermb_getx_repo/core/constants/constants.dart';
import 'package:lmhung_freshermb_getx_repo/core/localization/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/biometric/biometric_auth_service.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/biometric/did_change_authlocal_service.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/secure_storage/token/token_manager.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/secure_storage_service.dart';

import '../../../../core/common_widget/animation/shake_widget.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/app_toast.dart';
import '../../domain/params/login_params.dart';
import '../../domain/usecases/auth_usecase.dart';

class LoginController extends GetxController {
  final AuthUseCase _loginUseCase;
  final GetStorage _storage = Get.find<GetStorage>();
  final BiometricAuthService _biometricAuth = BiometricAuthService();
  final DidChangeAuthLocalService _didChangeAuthLocal =
      DidChangeAuthLocalService();

  LoginController(this._loginUseCase);

  /// Cờ đánh dấu có phát hiện thay đổi sinh trắc học cần xác nhận
  /// sau khi người dùng đăng nhập bằng mật khẩu.
  final RxBool _pendingBiometricChangeAck = false.obs;

  var isLoading = false.obs;
  final errorMessage = ''.obs;

  // giới hạn số laanf dang nhapp sai
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

  // Biến flag: chỉ hiển thị validation error sau lần submit đầu tiên
  final RxBool hasSubmittedOnce = false.obs;

  // Reactive validation errors (luôn được cập nhật, nhưng chỉ hiển thị khi hasSubmittedOnce=true)
  final Rx<String?> userNameError = Rx<String?>(null);
  final Rx<String?> passwordError = Rx<String?>(null);

  /// Chỉ hiển thị error text nếu đã submit ít nhất 1 lần
  String? get displayedUserNameError =>
      hasSubmittedOnce.value ? userNameError.value : null;

  String? get displayedPasswordError =>
      hasSubmittedOnce.value ? passwordError.value : null;

  //Biển state ô nhập mật khẩu
  final passwordText = ''.obs;
  final TextEditingController passwordController = TextEditingController();
  late FocusNode passwordFocus;
  final userNameShakeKey = GlobalKey<ShakeWidgetState>().obs;
  final passwordShakeKey = GlobalKey<ShakeWidgetState>().obs;

  @override
  void onInit() {
    userNameFocus = FocusNode();
    passwordFocus = FocusNode();
    userNameController.addListener(() {
      userNameText.value = userNameController.text;
    });
    passwordController.addListener(() {
      passwordText.value = passwordController.text;
    });
    _setupValidationListeners();
    _checkLockoutStatus();
    _initBiometric();
    super.onInit();
  }

  void _setupValidationListeners() {
    // Debounced validation on text changes
    ever(userNameText, (_) => _validateUserName());
    ever(passwordText, (_) => _validatePassword());
  }

  void _validateUserName() {
    userNameError.value = FormValidator.validateUsername(userNameText.value);
  }

  void _validatePassword() {
    passwordError.value = FormValidator.validatePassword(passwordText.value);
  }

  /// Returns true if all fields are valid (no error messages).
  bool get isFormValid {
    _validateUserName();
    _validatePassword();
    return userNameError.value == null && passwordError.value == null;
  }

  Future<void> _initBiometric() async {
    final available = await _biometricAuth.isBiometricAvailable();
    isBiometricAvailable.value = available;
    if (available) {
      biometricTypeName.value = await _biometricAuth.getBiometricDisplayName();
      final savedUsername = await SecureStorageService.readData(
        Constants.biometricUsernameKey,
      );
      final savedPassword = await SecureStorageService.readData(
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
        lockoutMessage.value = LocaleKeys.loginLocked.trParams({
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
      lockoutMessage.value = LocaleKeys.loginLocked.trParams({
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

  Future<void> login({bool fromBiometricChange = false}) async {
    // Đánh dấu đã submit → bắt đầu hiển thị validation error realtime
    if (!hasSubmittedOnce.value) {
      hasSubmittedOnce.value = true;
    }
    // Validate lại ngay lập tức
    _validateUserName();
    _validatePassword();

    // Kiểm tra nếu bị lock
    if (isLocked.value) {
      AppToast.showError(
        title: LocaleKeys.loginLockedButton.tr,
        message: lockoutMessage.value,
      );
      return;
    }

    String username = userNameText.value.trim();
    String password = passwordText.value.trim();
    if (!isFormValid) {
      AppToast.showError(
        title: LocaleKeys.loginFailed.tr,
        message: LocaleKeys.invalidCredentials.tr,
      );
      // Chỉ shake đúng ô input bị lỗi
      if (userNameError.value != null) {
        userNameShakeKey.value.currentState?.shake();
      }
      if (passwordError.value != null) {
        passwordShakeKey.value.currentState?.shake();
      }
      return;
    }
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final request = LoginParams(userName: username, password: password);

      final result = await _loginUseCase(request);
      final response = result.fold(
        (failure) => throw Exception(failure.message),
        (token) => token,
      );
      if (response.accessToken.isNotEmpty) {
        TextInput.finishAutofillContext(shouldSave: true);
        _resetLoginAttempts(); // Reset attempts on successful login
        await _handleLoginSuccess(
          response.accessToken,
          username: username,
          password: password,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();

      // tăng số lần đăng nhập sai
      _incrementAttemptCount();

      if (isLocked.value) {
        AppToast.showError(
          title: LocaleKeys.loginLockedButton.tr,
          message: lockoutMessage.value,
        );
      } else {
        final attemptsLeft =
            Constants.maxLoginAttempts - loginAttemptCount.value;
        final subtitle = attemptsLeft > 0
            ? LocaleKeys.loginAttemptsLeft.trParams({
                's': attemptsLeft.toString(),
              })
            : errorMessage.value;
        AppToast.showError(title: LocaleKeys.loginFailed.tr, message: subtitle);
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Xử lý logic chung sau khi login thành công (dùng cho cả login password và biometric)
  Future<void> _handleLoginSuccess(
    String accessToken, {
    String? username,
    String? password,
  }) async {
    //  Đồng bộ token vào TokenManager để lưu cả access token và thời gian hết hạn
    final tokenManager = Get.find<TokenManager>();
    await tokenManager.saveToken(accessToken);

    // Lưu thông tin xác thực sinh học
    if (username != null && password != null) {
      await _saveBiometricCredentials(username, password);
    }

    // Lưu token sinh trắc học để dùng cho lần kiểm tra sau
    await _saveBiometricToken();

    // Xác nhận thay đổi sinh trắc học nếu có yêu cầu chờ
    if (_pendingBiometricChangeAck.value) {
      await _didChangeAuthLocal.acknowledgeChange();
      _pendingBiometricChangeAck.value = false;
      AppToast.showSuccess(title: LocaleKeys.biometricChangedAcknowledged.tr);
    }

    // Chuyển đến dashboard
    Get.offAllNamed(Routes.dashboard);
    AppToast.showSuccess(title: LocaleKeys.loginSuccess.tr);
  }

  /// Lưu thông tin đăng nhập và dữ liệu sinh học sau khi đăng nhập (dùng SecureStorage)
  Future<void> _saveBiometricCredentials(
    String username,
    String password,
  ) async {
    await SecureStorageService.writeData(
      Constants.biometricUsernameKey,
      username,
    );
    await SecureStorageService.writeData(
      Constants.biometricPasswordKey,
      password,
    );
    isBiometricEnabled.value = true;
  }

  /// Lưu token sinh trắc học để dùng cho lần kiểm tra thay đổi sau này (dùng SecureStorage).
  Future<void> _saveBiometricToken() async {
    try {
      final token = await _didChangeAuthLocal.getCurrentToken();
      await SecureStorageService.writeData(Constants.biometricTokenKey, token);
    } catch (_) {
      // Lưu token thất bại, không critical
    }
  }

  /// Đăng nhập bằng sinh trắc học
  Future<bool> loginWithBiometric() async {
    if (!isBiometricAvailable.value || !isBiometricEnabled.value) {
      return false;
    }

    try {
      // Kiểm tra thay đổi sinh trắc học
      final savedToken = await SecureStorageService.readData(
        Constants.biometricTokenKey,
      );
      final status = await _didChangeAuthLocal.checkBiometricChanged(
        savedToken: savedToken,
      );

      // Xử lý rẽ nhánh
      if (status == AuthLocalStatus.changed) {
        //Phát hiện thay đổi → chặn đăng nhập sinh trắc học
        _pendingBiometricChangeAck.value = true;
        AppToast.showError(
          title: LocaleKeys.biometricLoginFailed.tr,
          message: LocaleKeys.biometricChangedWarning.tr,
        );
        return false;
      }

      if (status == AuthLocalStatus.invalid) {
        // Sinh trắc học không khả dụng / lỗi
        AppToast.showError(
          title: LocaleKeys.biometricLoginFailed.tr,
          message: LocaleKeys.biometricError.tr,
        );
        return false;
      }

      // Không có thay đổi → an toàn
      // Xác thực người dùng qua local_auth ──
      final authenticated = await _biometricAuth.authenticate(
        reason: LocaleKeys.biometricLoginReason.tr,
      );
      if (!authenticated) return false;

      // Lấy thông tin xác thực từ vân tay đã lưu (dùng SecureStorage)
      final savedUsername =
          await SecureStorageService.readData(Constants.biometricUsernameKey) ??
          '';
      final savedPassword =
          await SecureStorageService.readData(Constants.biometricPasswordKey) ??
          '';

      if (savedUsername.isEmpty || savedPassword.isEmpty) {
        isBiometricEnabled.value = false;
        return false;
      }

      // Đăng nhập bằng thông tin xác thực đã lưu
      try {
        isLoading.value = true;
        errorMessage.value = '';

        final request = LoginParams(
          userName: savedUsername,
          password: savedPassword,
        );
        final result = await _loginUseCase(request);
        final response = result.fold(
          (failure) => throw Exception(failure.message),
          (token) => token,
        );
        if (response.accessToken.isNotEmpty) {
          _resetLoginAttempts();
          await _handleLoginSuccess(response.accessToken);
          return true;
        }
      } catch (e) {
        errorMessage.value = e.toString();
        AppToast.showError(
          title: LocaleKeys.loginFailed.tr,
          message: LocaleKeys.biometricLoginFailedCredentials.tr,
        );
      } finally {
        isLoading.value = false;
      }
      return false;
    } on BiometricException catch (e) {
      if (e.message != LocaleKeys.biometricCanceled.tr) {
        AppToast.showError(
          title: LocaleKeys.biometricLoginFailed.tr,
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
