import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/token/token_manager.dart';

import '../../navigation/routes.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    _initApp();
  }

  Future<void> _initApp() async {
    // Đợi TokenManager khởi tạo và đọc token từ storage
    final tokenManager = Get.find<TokenManager>();
    await tokenManager.init();

    // Chờ một chút cho hiệu ứng splash
    await Future.delayed(const Duration(milliseconds: 120));

    splashNavigate();
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
