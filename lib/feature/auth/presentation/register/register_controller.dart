import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/animation/shake_widget.dart';
import 'package:lmhung_freshermb_getx_repo/core/common_widget/input/form_validator.dart';
import 'package:lmhung_freshermb_getx_repo/core/enum/locale_keys.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/secure_storage/token/token_manager.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/app_toast.dart';
import '../../domain/params/register_params.dart';
import '../../domain/usecases/auth_usecase.dart';

class RegisterController extends GetxController {
  final AuthUseCase _loginUseCase;

  RegisterController(this._loginUseCase);

  var isLoading = false.obs;
  final errorMessage = ''.obs;

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

  final userNameShakeKey = GlobalKey<ShakeWidgetState>().obs;
  final passwordShakeKey = GlobalKey<ShakeWidgetState>().obs;

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
    passwordController.addListener(() {
      passwordText.value = passwordController.text;
    });
    _setupValidationListeners();
    super.onInit();
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

  void _setupValidationListeners() {
    ever(userNameText, (_) => _validateUserName());
    ever(passwordText, (_) => _validatePassword());
  }

  void _validateUserName() {
    userNameError.value = FormValidator.validateUsername(userNameText.value);
  }

  void _validatePassword() {
    passwordError.value = FormValidator.validatePassword(passwordText.value);
  }

  /// Là true nếu tất cả các trường đều hợp lệ (không có lỗi)
  bool get isFormValid {
    _validateUserName();
    _validatePassword();
    return userNameError.value == null && passwordError.value == null;
  }

  Future<void> register() async {
    // Đánh dấu đã submit → bắt đầu hiển thị validation error realtime
    if (!hasSubmittedOnce.value) {
      hasSubmittedOnce.value = true;
    }
    // Validate lại ngay lập tức
    _validateUserName();
    _validatePassword();

    String username = userNameText.value.trim();
    String password = passwordText.value.trim();
    if (!isFormValid) {
      AppToast.showError(
        message: LocaleKeys.invalidCredentials.tr,
        title: LocaleKeys.registerFailed.tr,
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

      final request = RegisterParams(userName: username, password: password);

      final result = await _loginUseCase.register(request);
      final response = result.fold(
        (failure) => throw Exception(failure.message),
        (token) => token,
      );
      if (response.accessToken.isNotEmpty) {
        // Đồng bộ token vào TokenManager để lưu cả access token và thời gian hết hạn
        final tokenManager = Get.find<TokenManager>();
        await tokenManager.saveToken(response.accessToken);

        Get.offAllNamed(Routes.dashboard);
        AppToast.showSuccess(title: LocaleKeys.registerSuccess.tr);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      AppToast.showError(
        message: errorMessage.value,
        title: LocaleKeys.registerFailed.tr,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
