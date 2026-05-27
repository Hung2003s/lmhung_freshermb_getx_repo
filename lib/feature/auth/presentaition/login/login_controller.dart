import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/gen/colors.gen.dart';
import 'package:lmhung_freshermb_getx_repo/navigation/routes.dart';
import '../../data/models/login_model/login_model.dart';
import '../../domain/usecases/auth_usecase.dart';

class LoginController extends GetxController{
  final AuthUseCase _loginUseCase;

  LoginController(this._loginUseCase);

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
    if(userNameText.value.isNotEmpty) {
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
    String username = userNameText.value.trim();
    String password = passwordText.value.trim();
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Đăng nhập thất bại',
        'Vui lòng nhập thông tin đăng nhập.',
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
          Get.offAllNamed(Routes.dashboard);
          Get.snackbar(
            'Đăng nhập thành công',
            errorMessage.value,
            snackPosition: SnackPosition.TOP,
            backgroundColor: ColorName.greenLight,
            colorText: Colors.white,
          );
        }
    } catch (e) {
      errorMessage.value = e.toString();

      Get.snackbar(
        'Đăng nhập thất bại',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToRegister() {
    Get.toNamed(Routes.register);
  }
}