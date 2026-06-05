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
    // 1.  DataSource ()
    Get.lazyPut<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(Get.find()),
    );

    // 2.  Repository
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(
        remoteDataSource: Get.find<ProductRemoteDataSource>(),
      ),
    );

    // 3.  UseCases
    Get.lazyPut(() => AddProductUseCase(Get.find()));
    Get.lazyPut(() => UpdateProductUseCase(Get.find()));

    // 4.  Controller
    Get.lazyPut<ProductInfoController>(
      () => ProductInfoController(Get.find(), Get.find()),
    );
  }
}
