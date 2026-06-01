import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_add_models/category_add_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/update_category_model/update_category_model.dart';

import '../../../../../core/network/data/data_state.dart';
import '../../models/category_delete_model/category_delete_model.dart';
import '../../models/category_response/category_model.dart';

abstract class CategoryRemoteDataSource {
  ///Lấy danh sách danh mục
  Future<DataState<CategoryResponse>> getCategories({
    int page = 1,
    int limit = 20,
  });

  /// Thêm danh mục
  Future<DataState<CategoryAddRes>> addCategories(CategoryAddParams params);

  ///Cập nhật danh mục
  Future<DataState<UpdateCategoryRes>> updateCategories(
    UpdateCategoryParam params,
    int id,
  );

  ///Xoá danh mục
  Future<DataState<DeleteCategoryRes>> deleteCategories(int id);
}
