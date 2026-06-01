import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_info/product_info_controller.dart';

import '../../data/datasources/remote/product_remote_data_source.dart';
import '../../data/datasources/remote/product_remote_data_source_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/add_product_use_case.dart';
import '../../domain/usecases/update_product_use_case.dart';

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

    // 3. Inject UseCases
    Get.lazyPut(() => AddProductUseCase(Get.find()));
    Get.lazyPut(() => UpdateProductUseCase(Get.find()));

    // 4. Inject Controller cho tầng Presentation dùng
    Get.lazyPut<ProductInfoController>(
      () => ProductInfoController(Get.find(), Get.find()),
    );
  }
}
