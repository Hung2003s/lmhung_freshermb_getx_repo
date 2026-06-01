import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call({
    String? keyword,
    int? categoryId,
    required int page,
    required int limit,
  }) async {
    return repository.getListProductById(
      keyword: keyword,
      categoryId: categoryId,
      page: page,
      limit: limit,
    );
  }
}
