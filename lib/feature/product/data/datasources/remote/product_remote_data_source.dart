import '../../../../../core/network/data/data_state.dart';
import '../../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<DataState<ProductResponse>> getListProductById({
    String? keyword,
    int? categoryId,
    required int page,
    required int limit,
  });

  Future<DataState<AddProductRes>> addProduct({
    required ProductInfoParam params,
  });
  Future<DataState<UpdateProductRes>> updateProduct({
    required ProductInfoParam params,
    required int id,
  });
  Future<DataState<DeleteProductRes>> deleteProduct({required int id});
}
