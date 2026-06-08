import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/categories_entity.dart';
import '../params/add_category_params.dart';
import '../params/update_category_params.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    int page = 1,
    int limit = 20,
  });
  Future<Either<Failure, int>> addCategories(AddCategoryParams params);
  Future<Either<Failure, bool>> updateCategories(
    UpdateCategoryParams params,
    int id,
  );
  Future<Either<Failure, bool>> deleteCategories(int id);
}
