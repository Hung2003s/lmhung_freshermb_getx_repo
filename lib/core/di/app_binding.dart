import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/dio_client.dart';
import 'package:lmhung_freshermb_getx_repo/feature/setting/presentation/setting_controller.dart';

import '../storage/secure_storage/token/token_manager.dart';
import '../storage/secure_storage_service.dart';

/// Nơi đăng ký các service được sử dụng trong suốt quá trình chạy ứng dụng

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DioClient>(DioClient(), permanent: true);
    Get.put<SecureStorageService>(SecureStorageService(), permanent: true);
    Get.put<GetStorage>(GetStorage(), permanent: true);
    Get.put<TokenManager>(TokenManager(), permanent: true);
    Get.put<SettingController>(SettingController(), permanent: true);
  }
}
