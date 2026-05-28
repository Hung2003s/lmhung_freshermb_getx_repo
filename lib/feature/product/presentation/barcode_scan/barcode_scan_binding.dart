import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/barcode_scan/barcode_scan_controller.dart';

class BarcodeScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarcodeScanController>(() => BarcodeScanController());
  }
}
