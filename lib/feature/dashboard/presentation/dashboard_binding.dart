import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/dashboard/presentation/dashboard_controller.dart';


class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(()=>DashboardController(), fenix: true);
  }
}