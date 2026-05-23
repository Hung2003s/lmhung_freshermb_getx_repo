import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/dio_client.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/secure_storage_service.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/token/token_manager.dart';
import 'package:lmhung_freshermb_getx_repo/feature/setting/presentation/setting_controller.dart';

/**
 * Nơi đăng ký các service được sử dụng trong suốt quá trình chạy ứng dụng
 */


class AppBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<DioClient>(DioClient(), permanent: true);
    Get.put<SecureStorageService>(SecureStorageService(), permanent: true);
    Get.put<TokenManager>(TokenManager(), permanent: true);
    Get.put<SettingController>(SettingController(), permanent: true);
  }
}
