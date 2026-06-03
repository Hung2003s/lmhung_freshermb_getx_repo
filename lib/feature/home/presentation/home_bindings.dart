import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/home/presentation/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
