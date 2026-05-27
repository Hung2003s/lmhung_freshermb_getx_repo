import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../../data/model/product_model.dart';
import '../entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getListProductById({
    required ProductParams params
  });

  Future<Either<Failure, int>> addProduct(ProductInfoParam params);
  Future<Either<Failure, bool>> updateProduct(ProductInfoParam params, int id);
  Future<Either<Failure, bool>> deleteProduct(int id);
}
