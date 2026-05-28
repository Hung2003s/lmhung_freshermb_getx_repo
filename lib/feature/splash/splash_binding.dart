import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(), permanent: false);
  }
}
