import 'package:lmhung_freshermb_getx_repo/feature/product/data/datasources/remote/product_remote_data_source.dart';

import '../../../../../core/network/api_endpoint.dart';
import '../../../../../core/network/data/data_state.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/network/error/remote_exception_handle.dart';
import '../../model/product_model.dart';

class ProductRemoteDataSourceImpl with RemoteExceptionHandler implements ProductRemoteDataSource {
  final DioClient _dioClient;

  ProductRemoteDataSourceImpl(this._dioClient);

  @override
  Future<DataState<ProductResponse>> getListProductById({
    String? keyword,
    int? categoryId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoint.product,
        queryParameters: {
          'keyword': ?keyword,
          'category_id': ?categoryId,
          'page': page,
          'limit': limit,
        },
        requiresToken: true,
      );
      return DataSuccess(ProductResponse.fromJson(response.data));
    } catch (e) {
      return handleNetworkException<ProductResponse>(e);
    }
  }

  @override
  Future<DataState<AddProductRes>> addProduct({
    required ProductInfoParam params,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoint.product,
        data: params,
        requiresToken: true,
      );
      return DataSuccess(AddProductRes.fromJson(response.data));
    } catch (e) {
      return handleNetworkException<AddProductRes>(e);
    }
  }

  @override
  Future<DataState<DeleteProductRes>> deleteProduct({required int id}) async {
    try {
      final response = await _dioClient.delete(
        '${ApiEndpoint.product}/$id',
        requiresToken: true,
      );
      return DataSuccess(DeleteProductRes.fromJson(response.data));
    } catch (e) {
      return handleNetworkException<DeleteProductRes>(e);
    }
  }

  @override
  Future<DataState<UpdateProductRes>> updateProduct({
    required ProductInfoParam params,
    required int id,
  }) async {
    try {
      final response = await _dioClient.put(
        '${ApiEndpoint.product}/$id',
        data: params,
        requiresToken: true,
      );

      return DataSuccess(UpdateProductRes.fromJson(response.data));
    } catch (e) {
      return handleNetworkException<UpdateProductRes>(e);
    }
  }
}
