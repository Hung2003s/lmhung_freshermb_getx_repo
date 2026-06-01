import '../../../../../core/network/data/data_state.dart';
import '../../models/product_model.dart' as product_model;

abstract class ProductRemoteDataSource {
  Future<DataState<product_model.ProductResponse>> getListProductById({
    String? keyword,
    int? categoryId,
    required int page,
    required int limit,
  });

  Future<DataState<product_model.AddProductRes>> addProduct({
    required product_model.ProductInfoDto params,
  });
  Future<DataState<product_model.UpdateProductRes>> updateProduct({
    required product_model.ProductInfoDto params,
    required int id,
  });
  Future<DataState<product_model.DeleteProductRes>> deleteProduct({
    required int id,
  });
}
