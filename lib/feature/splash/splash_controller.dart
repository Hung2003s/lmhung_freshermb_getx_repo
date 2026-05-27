import 'package:get/get.dart';

import '../../navigation/routes.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 120), () {
      splashNavigate();
    });
    super.onInit();
  }

  void splashNavigate() {
    Get.toNamed(Routes.login);
  }
}