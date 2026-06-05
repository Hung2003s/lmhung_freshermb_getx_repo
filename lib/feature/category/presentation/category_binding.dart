import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/core/cache/cache_manager.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/datasources/remote/category_remote_data.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/datasources/remote/category_remote_data_impl.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/repositories/category_repository_impl.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/usecases/get_categories_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/usecases/add_category_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/usecases/update_category_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/usecases/delete_category_use_case.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';

import '../domain/repositories/categories_repository.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Inject DataSource
    Get.lazyPut<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(Get.find()),
    );

    // 2. Inject Repository — CacheManager được lấy từ AppBinding (đã đăng ký khi app khởi động)
    Get.lazyPut<CategoriesRepository>(
      () => CategoryRepositoryImpl(
        remoteDataSource: Get.find<CategoryRemoteDataSource>(),
        cacheManager: Get.find<CacheManager>(),
      ),
    );

    // 3. Inject UseCases
    Get.lazyPut(() => GetCategoriesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => AddCategoryUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => UpdateCategoryUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => DeleteCategoryUseCase(Get.find()), fenix: true);

    // 4. Inject Controller cho tầng Presentation dùng
    Get.lazyPut<CategoryController>(
      () => CategoryController(Get.find(), Get.find(), Get.find(), Get.find()),
      fenix: true,
    );
  }
}
