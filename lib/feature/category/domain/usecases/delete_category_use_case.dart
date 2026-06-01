import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../repositories/categories_repository.dart';

class DeleteCategoryUseCase {
  final CategoriesRepository repository;

  DeleteCategoryUseCase(this.repository);

  Future<Either<Failure, bool>> call(int id) async {
    return repository.deleteCategories(id);
  }
}
