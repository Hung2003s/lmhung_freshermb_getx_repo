import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/cache/cache_manager.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/dio_client.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/domain/usecases/logout_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/setting/presentation/setting_controller.dart';

import '../storage/secure_storage/token/token_manager.dart';
import '../storage/secure_storage_service.dart';

/// Nơi đăng ký các service được sử dụng trong suốt quá trình chạy ứng dụng.
///
/// Chiến lược:
/// - Eager (permanent): GetStorage — nhẹ, cần từ splash
/// - Lazy (lazyPut):   DioClient, SecureStorageService, TokenManager
/// - Lazy (lazyPut):   CacheManager — singleton dùng chung toàn app
/// - Lazy (lazyPut):   LogoutUseCase, SettingController
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

    // CacheManager: singleton toàn app — mọi repository cache đều đi qua đây.
    // invalidateAll() được gọi khi logout để xóa sạch dữ liệu người dùng.
    Get.lazyPut<CacheManager>(() => CacheManager(), fenix: true);

    Get.lazyPut(
      () => LogoutUseCase(
        tokenManager: Get.find(),
        cacheManager: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<SettingController>(
      () => SettingController(Get.find<LogoutUseCase>()),
      fenix: true,
    );
  }
}
