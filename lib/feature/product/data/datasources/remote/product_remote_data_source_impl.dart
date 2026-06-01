import 'package:lmhung_freshermb_getx_repo/core/network/api_endpoint.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/data/data_state.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/dio_client.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/error/remote_exception_handle.dart';

import '../../datasources/remote/product_remote_data_source.dart';
import '../../models/product_model.dart' as product_model;

class ProductRemoteDataSourceImpl
    with RemoteExceptionHandler
    implements ProductRemoteDataSource {
  final DioClient _dioClient;

  ProductRemoteDataSourceImpl(this._dioClient);

  @override
  Future<DataState<product_model.ProductResponse>> getListProductById({
    String? keyword,
    int? categoryId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoint.product,
        queryParameters: {
          if (keyword != null) 'keyword': keyword,
          if (categoryId != null) 'category_id': categoryId,
          'page': page,
          'limit': limit,
        },
        requiresToken: true,
      );
      return DataSuccess(product_model.ProductResponse.fromJson(response.data));
    } catch (e) {
      return handleNetworkException<product_model.ProductResponse>(e);
    }
  }

  @override
  Future<DataState<product_model.AddProductRes>> addProduct({
    required product_model.ProductInfoDto params,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.product,
        data: params.toJson(),
        requiresToken: true,
      );
      return DataSuccess(product_model.AddProductRes.fromJson(response.data));
    } catch (e) {
      return handleNetworkException<product_model.AddProductRes>(e);
    }
  }

  @override
  Future<DataState<product_model.DeleteProductRes>> deleteProduct({
    required int id,
  }) async {
    try {
      final response = await _dioClient.delete(
        '${ApiEndpoint.product}/$id',
        requiresToken: true,
      );
      return DataSuccess(
        product_model.DeleteProductRes.fromJson(response.data),
      );
    } catch (e) {
      return handleNetworkException<product_model.DeleteProductRes>(e);
    }
  }

  @override
  Future<DataState<product_model.UpdateProductRes>> updateProduct({
    required product_model.ProductInfoDto params,
    required int id,
  }) async {
    try {
      final response = await _dioClient.put(
        '${ApiEndpoint.product}/$id',
        data: params,
        requiresToken: true,
      );

      return DataSuccess(
        product_model.UpdateProductRes.fromJson(response.data),
      );
    } catch (e) {
      return handleNetworkException<product_model.UpdateProductRes>(e);
    }
  }
}
