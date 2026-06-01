import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entity/product_entity.dart';
import '../params/product_params.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getListProductById({
    String? keyword,
    int? categoryId,
    required int page,
    required int limit,
  });

  Future<Either<Failure, int>> addProduct(ProductInfoParam params);
  Future<Either<Failure, bool>> updateProduct(ProductInfoParam params, int id);
  Future<Either<Failure, bool>> deleteProduct(int id);
}
