import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/domain/usecases/auth_usecase.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/presentaition/register/register_controller.dart';

import '../../data/datasources/local/auth_local_data_source.dart';
import '../../data/datasources/local/auth_local_data_source_impl.dart';
import '../../domain/repositories/auth_repository.dart';

class RegisterBinding  extends  Bindings {
  @override
  void dependencies() {
// 1. Inject DataSource (Cần truyền instance Dio từ core hệ thống vào)
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<AuthLocalDataSource>(() => AuthLocalDataSourceImpl());

    // 2. Inject Repository
    Get.lazyPut<AuthRepository>(()=> AuthRepositoryImpl(
      remoteDataSource: Get.find<AuthRemoteDataSource>(),
      localDataSource: Get.find<AuthLocalDataSource>(),));

    // 3. Inject UseCase
    Get.lazyPut(() => AuthUseCase(Get.find()));

    // 4. Inject Controller cho tầng Presentation dùng
    Get.lazyPut<RegisterController>(() => RegisterController(Get.find()));  }

}