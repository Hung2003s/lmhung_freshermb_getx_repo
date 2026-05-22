import 'package:get/get.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/datasources/remote/category_remote_data.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/datasources/remote/category_remote_data_impl.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/repositories/category_repository_impl.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/domain/usecases/category_usecase.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/presentation/category_controller.dart';

import '../domain/repositories/categories_repository.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Inject DataSource (Cần truyền instance Dio từ core hệ thống vào)
    Get.lazyPut<CategoryRemoteData>(() => CategoryRemoteDataImpl(Get.find()));

    // 2. Inject Repository
    Get.lazyPut<CategoriesRepository>(()=> CategoryRepositoryImpl(
      remoteDataSource: Get.find<CategoryRemoteData>(),
     ));

    // 3. Inject UseCase
    Get.lazyPut(() => CategoryUseCase(Get.find()));

    // 4. Inject Controller cho tầng Presentation dùng
    Get.lazyPut<CategoryController>(() => CategoryController(Get.find()));
  }
}