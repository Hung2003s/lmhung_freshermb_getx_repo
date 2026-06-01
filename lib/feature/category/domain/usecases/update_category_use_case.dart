import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../params/update_category_params.dart';
import '../repositories/categories_repository.dart';

class UpdateCategoryUseCase {
  final CategoriesRepository repository;

  UpdateCategoryUseCase(this.repository);

  Future<Either<Failure, bool>> call(
    UpdateCategoryParams params,
    int id,
  ) async {
    return repository.updateCategories(params, id);
  }
}
