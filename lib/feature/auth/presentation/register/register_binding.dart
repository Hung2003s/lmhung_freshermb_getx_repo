import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/secure_storage/token/token_manager.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/domain/usecases/auth_usecase.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/presentation/register/register_controller.dart';

import '../../data/datasources/local/auth_local_data_source.dart';
import '../../data/datasources/local/auth_local_data_source_impl.dart';
import '../../domain/repositories/auth_repository.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Inject DataSource
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(Get.find()),
    );
    Get.lazyPut<AuthLocalDataSource>(() => AuthLocalDataSourceImpl());

    // 2. Inject Repository
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: Get.find<AuthRemoteDataSource>(),
        localDataSource: Get.find<AuthLocalDataSource>(),
        tokenManager: Get.find<TokenManager>(),
      ),
    );

    // 3. Inject UseCase
    Get.lazyPut(() => AuthUseCase(Get.find()));

    // 4. Inject Controller cho tầng Presentation dùng
    Get.lazyPut<RegisterController>(() => RegisterController(Get.find()));
  }
}
