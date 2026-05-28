import 'package:lmhung_freshermb_getx_repo/core/network/data/data_state.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_add_models/category_add_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_delete_model/category_delete_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/update_category_model/update_category_model.dart';

import '../../../../../core/network/api_endpoint.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/network/error/remote_exception_handle.dart';
import '../../models/category_response/category_model.dart';
import 'category_remote_data.dart';

class CategoryRemoteDataImpl with RemoteExceptionHandler implements CategoryRemoteData {
  final DioClient _dioClient;

  CategoryRemoteDataImpl(this._dioClient);


  ///Lấy danh sâch danh mục
  @override
  Future<DataState<CategoryResponse>> getCategories({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoint.categories,
        requiresToken: true,
        queryParameters: {'page': page, 'limit': limit},
      );

      return DataSuccess(CategoryResponse.fromJson(response.data));
    } catch (e) {
      return handleNetworkException<CategoryResponse>(e);
    }
  }
  /// Thêm danh mục
  @override
  Future<DataState<CategoryAddRes>> addCategories(
    CategoryAddParams params,
  ) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.categories,
        requiresToken: true,
        data: params,
      );
      return DataSuccess(CategoryAddRes.fromJson(response.data));
    } catch (e) {
      return handleNetworkException<CategoryAddRes>(e);
    }
  }

  ///Cập nhật danh mục
  @override
  Future<DataState<UpdateCategoryRes>> updateCategories(
    UpdateCategoryParam params,
    int id,
  ) async {
    try {
      final response = await _dioClient.put(
        '${ApiEndpoint.categories}/$id',
        data: params,
        requiresToken: true,
      );
      return DataSuccess(UpdateCategoryRes.fromJson(response.data));
    } catch (e) {
      return handleNetworkException<UpdateCategoryRes>(e);
    }
  }

  ///Xoá danh mục
  @override
  Future<DataState<DeleteCategoryRes>> deleteCategories(int id) async {
    try {
      final response = await _dioClient.delete(
        '${ApiEndpoint.categories}/$id',
        requiresToken: true,
      );
      return DataSuccess(DeleteCategoryRes.fromJson(response.data));
    } catch (e) {
      return handleNetworkException<DeleteCategoryRes>(e);
    }
  }
}
