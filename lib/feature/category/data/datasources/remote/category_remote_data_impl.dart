import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/data/data_state.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_add_models/category_add_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_delete_model/category_delete_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/update_category_model/update_category_model.dart';
import '../../../../../core/network/api_endpoint.dart';
import '../../../../../core/network/dio_client.dart';
import '../../models/category_response/category_model.dart';
import 'category_remote_data.dart';

class CategoryRemoteDataImpl implements CategoryRemoteData {
  final DioClient _dioClient;

  CategoryRemoteDataImpl(this._dioClient);

  @override
  Future<DataState<CategoryResponse>> getCategories() async {
    try {
      final response = await _dioClient.get(
        ApiEndpoint.categories,
        requiresToken: true,
      );

        return DataSuccess(CategoryResponse.fromJson(response.data));
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final errorResponse = ResponseError.fromJson(e.response!.data);
        return DataFailed(errorResponse); // Hết lỗi đỏ!
      }
      return DataFailed(ResponseError(message: 'Mất kết nối mạng',));
    } catch (e) {
      throw Exception('$e');
    }
  }

  @override
  Future<DataState<CategoryAddRes>> addCategories(CategoryAddParams params) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.categories,
        requiresToken: true,
        data: params
      );
      return DataSuccess(CategoryAddRes.fromJson(response.data));
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final errorResponse = ResponseError.fromJson(e.response!.data);
        return DataFailed(errorResponse); // Hết lỗi đỏ!
      }
      return DataFailed(ResponseError(message: 'Mất kết nối mạng',));
    } catch (e) {
      throw Exception('$e');
    }
  }

  @override
  Future<DataState<UpdateCategoryRes>> updateCategories(UpdateCategoryParam params, int id) async {
    try {
      final response = await _dioClient.put(
        '${ApiEndpoint.categories}/$id',
        data: params,
        requiresToken: true,
      );
      return DataSuccess(UpdateCategoryRes.fromJson(response.data));
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final errorResponse = ResponseError.fromJson(e.response!.data);
        return DataFailed(errorResponse); // Hết lỗi đỏ!
      }
      return DataFailed(ResponseError(message: 'Mất kết nối mạng',));
    } catch (e) {
      throw Exception('$e');
    }
  }

  @override
  Future<DataState<DeleteCategoryRes>> deleteCategories(int id) async {
    try {
      final response = await _dioClient.delete(
        '${ApiEndpoint.categories}/$id',
        requiresToken: true,
      );
      return DataSuccess(DeleteCategoryRes.fromJson(response.data));
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final errorResponse = ResponseError.fromJson(e.response!.data);
        return DataFailed(errorResponse); // Hết lỗi đỏ!
      }
      return DataFailed(ResponseError(message: 'Mất kết nối mạng',));
    } catch (e) {
      throw Exception('$e');
    }
  }
}
