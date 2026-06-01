import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../params/add_category_params.dart';
import '../repositories/categories_repository.dart';

class AddCategoryUseCase {
  final CategoriesRepository repository;

  AddCategoryUseCase(this.repository);

  Future<Either<Failure, int>> call(AddCategoryParams params) async {
    return repository.addCategories(params);
  }
}
