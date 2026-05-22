import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_info/product_info_controller.dart';

import '../../data/datasources/remote/product_remote_data_source.dart';
import '../../data/datasources/remote/product_remote_data_source_impl.dart';
import '../../data/repository/product_repository_impl.dart';
import '../../domain/product_use_case/product_use_case.dart';
import '../../domain/repository/product_repository.dart';

class ProductInfoBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Inject DataSource (Cần truyền instance Dio từ core hệ thống vào)
    Get.lazyPut<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(Get.find()),
    );

    // 2. Inject Repository
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(
        remoteDataSource: Get.find<ProductRemoteDataSource>(),
      ),
    );

    // 3. Inject UseCase
    Get.lazyPut(() => ProductUseCase(Get.find()));

    // 4. Inject Controller cho tầng Presentation dùng
    Get.lazyPut<ProductInfoController>(() => ProductInfoController(Get.find()));
  }
}
