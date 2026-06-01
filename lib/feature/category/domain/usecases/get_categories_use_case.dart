import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/categories_entity.dart';
import '../repositories/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call({
    int page = 1,
    int limit = 20,
  }) async {
    return repository.getCategories(page: page, limit: limit);
  }
}
