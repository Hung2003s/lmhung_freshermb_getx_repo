import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/data/models/register_model/register_model.dart';

import '../../../../core/utils/app_toast.dart';
import '../../../../navigation/routes.dart';
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

  Future<void> register() async {
    String username = userNameText.value.trim();
    String password = passwordText.value.trim();
    if (username.isEmpty || password.isEmpty) {
      AppToast.showError(
        message: 'invalid_credentials'.tr,
        title: 'register_failed'.tr,
      );
      return;
    }
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final request = RegisterParams(userName: username, password: password);

      final response = await _loginUseCase.register(request);
      if (response.accessToken.isNotEmpty && response.accessToken != null) {
        Get.offAllNamed(Routes.dashboard);
        AppToast.showSuccess(
          title: 'register_success'.tr,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      AppToast.showError(
        message: errorMessage.value,
        title: 'register_failed'.tr,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
