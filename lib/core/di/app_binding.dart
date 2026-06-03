import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/dio_client.dart';
import 'package:lmhung_freshermb_getx_repo/feature/setting/presentation/setting_controller.dart';

import '../storage/secure_storage/token/token_manager.dart';
import '../storage/secure_storage_service.dart';

/// Nơi đăng ký các service được sử dụng trong suốt quá trình chạy ứng dụng
///
/// Chiến lược:
/// - Eager (permanent): GetStorage — nhẹ, cần từ splash
/// - Lazy (lazyPut):   DioClient, SecureStorageService, TokenManager — không cần ngay lúc startup
/// - Lazy (lazyPut):   SettingController — chỉ dùng khi mở settings page

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Eager: GetStorage rất nhẹ (< 1ms init) và cần ở splash screen
    Get.put<GetStorage>(GetStorage(), permanent: true);

    // Lazy: Các service chỉ dùng sau splash
    Get.lazyPut<DioClient>(() => DioClient(), fenix: true);
    Get.lazyPut<SecureStorageService>(
      () => SecureStorageService(),
      fenix: true,
    );
    Get.lazyPut<TokenManager>(() => TokenManager(), fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
  }
}
