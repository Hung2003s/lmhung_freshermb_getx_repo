import 'package:dartz/dartz.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_add_models/category_add_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/update_category_model/update_category_model.dart';

import '../../../../core/network/error/failures.dart';
import '../../data/models/category_delete_model/category_delete_model.dart';
import '../entities/categories_entity.dart';
abstract class CategoriesRepository {
  Future< Either<Failure,List<CategoryEntity>>> getCategories({int page = 1, int limit = 20});
  Future<Either<Failure, CategoryAddRes>> addCategories(CategoryAddParams params);
  Future<Either<Failure, UpdateCategoryRes>> updateCategories(UpdateCategoryParam params, int id);
  Future<Either<Failure, DeleteCategoryRes>>  deleteCategories( int id);
}
