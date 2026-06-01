import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/data/datasources/remote/product_remote_data_source.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/data/datasources/remote/product_remote_data_source_impl.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/data/repositories/product_repository_impl.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/usecases/get_products_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/usecases/add_product_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/usecases/update_product_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/usecases/delete_product_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/repositories/product_repository.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_controller.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/presentation/product_info/product_info_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Inject DataSource
    Get.lazyPut<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(Get.find()),
    );

    // 2. Inject Repository
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(
        remoteDataSource: Get.find<ProductRemoteDataSource>(),
      ),
    );

    // 3. Inject UseCases (each with single responsibility)
    Get.lazyPut(() => GetProductsUseCase(Get.find()));
    Get.lazyPut(() => AddProductUseCase(Get.find()));
    Get.lazyPut(() => UpdateProductUseCase(Get.find()));
    Get.lazyPut(() => DeleteProductUseCase(Get.find()));

    // 4. Inject Controllers cho tầng Presentation
    Get.lazyPut<ProductController>(
      () => ProductController(Get.find(), Get.find()),
    );
    Get.lazyPut<ProductInfoController>(
      () => ProductInfoController(Get.find(), Get.find()),
    );
  }
}
