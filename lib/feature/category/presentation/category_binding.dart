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
    // 1. Inject DataSource (Cần truyền instance Dio từ core hệ thống vào)
    Get.lazyPut<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(Get.find()),
    );

    // 2. Inject Repository — CacheManager lấy từ AppBinding (permanent singleton)
    Get.lazyPut<CategoriesRepository>(
      () => CategoryRepositoryImpl(
        remoteDataSource: Get.find<CategoryRemoteDataSource>(),
        cacheManager: Get.find<CacheManager>(),
      ),
    );

    // 3. Inject UseCases (each with single responsibility)
    Get.lazyPut(() => GetCategoriesUseCase(Get.find()));
    Get.lazyPut(() => AddCategoryUseCase(Get.find()));
    Get.lazyPut(() => UpdateCategoryUseCase(Get.find()));
    Get.lazyPut(() => DeleteCategoryUseCase(Get.find()));

    // 4. Inject Controller cho tầng Presentation dùng
    Get.lazyPut<CategoryController>(
      () => CategoryController(Get.find(), Get.find(), Get.find(), Get.find()),
    );
  }
}
