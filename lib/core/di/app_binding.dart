import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lmhung_freshermb_getx_repo/core/cache/cache_manager.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/dio_client.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/domain/usecases/logout_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/setting/presentation/setting_controller.dart';

import '../storage/secure_storage/token/token_manager.dart';
import '../storage/secure_storage_service.dart';

/// Nơi đăng ký các service dùng trong suốt vòng đời ứng dụng.
///
/// Chiến lược:
/// - permanent : GetStorage, DioClient, SecureStorageService, TokenManager, CacheManager
///              — cần ngay từ đầu hoặc dùng liên tục, không bao giờ bị dispose
/// - lazyPut   : LogoutUseCase, SettingController — chỉ khởi tạo khi cần
class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GetStorage>(GetStorage(), permanent: true);
    Get.put<DioClient>(DioClient(), permanent: true);
    Get.put<SecureStorageService>(SecureStorageService(), permanent: true);
    Get.put<TokenManager>(TokenManager(), permanent: true);

    // Singleton dùng chung toàn app: mọi repository cache đi qua đây.
    // invalidateAll() xóa sạch dữ liệu khi logout.
    Get.put<CacheManager>(CacheManager(), permanent: true);

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
