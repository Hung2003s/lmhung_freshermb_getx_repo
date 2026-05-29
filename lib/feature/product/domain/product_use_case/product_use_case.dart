import '../../data/model/product_model.dart';
import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class ProductUseCase {
  final ProductRepository repository;

  ProductUseCase(this.repository);

  Future<List<ProductEntity>> call({
    String? keyword,
    int? categoryId,
    required int page,
    required int limit,
  }) async {
    final result = await repository.getListProductById(
      keyword: keyword,
      categoryId: categoryId,
      page: page,
      limit: limit,
    );
    return result.fold(
      (failure) => throw Exception(failure.message),
      (list) => list,
    );
  }

  Future<int> addProduct(ProductInfoParam params) async {
    final result = await repository.addProduct(params);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (data) => data,
    );
  }

  Future<bool> updateProduct(ProductInfoParam params, int id) async {
    final result = await repository.updateProduct(params, id);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (data) => data,
    );
  }

  Future<bool> deleteProduct(int id) async {
    final result = await repository.deleteProduct(id);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (data) => data,
    );
  }
}
