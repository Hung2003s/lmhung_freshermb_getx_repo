import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/constants/constants.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';
import 'package:lmhung_freshermb_getx_repo/navigation/routes.dart';
import '../../data/models/login_model/login_model.dart';
import '../../domain/usecases/auth_usecase.dart';
import 'package:flutter/services.dart';

class LoginController extends GetxController {
  final AuthUseCase _loginUseCase;
  final GetStorage _storage = Get.find<GetStorage>();

  LoginController(this._loginUseCase);

  var isLoading = false.obs;
  final errorMessage = ''.obs;

  // Login attempt limiter
  final RxInt loginAttemptCount = 0.obs;
  final RxBool isLocked = false.obs;
  final RxString lockoutMessage = ''.obs;

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
    super.onInit();
  }

  void _checkLockoutStatus() {
    final lockoutTimeStr = _storage.read<String>(Constants.loginLockoutTimeKey);
    if (lockoutTimeStr != null) {
      final lockoutTime = DateTime.tryParse(lockoutTimeStr);
      if (lockoutTime != null && DateTime.now().isBefore(lockoutTime)) {
        // Still locked
        isLocked.value = true;
        final remainingMinutes = lockoutTime.difference(DateTime.now()).inMinutes + 1;
        lockoutMessage.value = 'login_locked'.trParams({'s': remainingMinutes.toString()});
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
        Duration(minutes: Constants.lockoutDurationMinutes),
      );
      _storage.write(Constants.loginLockoutTimeKey, lockoutUntil.toIso8601String());

      final remainingMinutes = Constants.lockoutDurationMinutes;
      lockoutMessage.value = 'login_locked'.trParams({'s': remainingMinutes.toString()});
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
    // Check if locked
    if (isLocked.value) {
      Get.snackbar(
        'login_locked_button'.tr,
        lockoutMessage.value,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    String username = userNameText.value.trim();
    String password = passwordText.value.trim();
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'login_failed'.tr,
        'invalid_credentials'.tr,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final request = LoginParams(
          userName: username,
          password: password);

      final response = await _loginUseCase(request);
        if (response.accessToken.isNotEmpty && response.accessToken != null) {
          TextInput.finishAutofillContext(shouldSave: true);
          // Reset attempts on successful login
          _resetLoginAttempts();
          Get.offAllNamed(Routes.dashboard);
          Get.snackbar(
            'login_success'.tr,
            errorMessage.value,
            snackPosition: SnackPosition.TOP,
            backgroundColor: ColorName.greenLight,
            colorText: Colors.white,
          );
        }
    } catch (e) {
      errorMessage.value = e.toString();

      // Increment failed attempt counter
      _incrementAttemptCount();

      if (isLocked.value) {
        Get.snackbar(
          'login_locked_button'.tr,
          lockoutMessage.value,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        final attemptsLeft = Constants.maxLoginAttempts - loginAttemptCount.value;
        final subtitle = attemptsLeft > 0
            ? 'login_attempts_left'.trParams({'s': attemptsLeft.toString()})
            : errorMessage.value;

        Get.snackbar(
          'login_failed'.tr,
          subtitle,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToRegister() {
    Get.toNamed(Routes.register);
  }
}