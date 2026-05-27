import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_delete_model/category_delete_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/update_category_model/update_category_model.dart';

import '../../data/models/category_add_models/category_add_model.dart';
import '../entities/categories_entity.dart';
import '../repositories/categories_repository.dart';
class CategoryUseCase {
  final CategoriesRepository repository;

  CategoryUseCase(this.repository);

  Future<List<CategoryEntity>> call({int page = 1, int limit = 20}) async {
    final result = await repository.getCategories(page: page, limit: limit);
    return result.fold(
            (failure) => throw Exception(failure.message),
        (list) => list
    );
  }
  Future<CategoryAddRes> add(CategoryAddParams params) async {
    final result = await repository.addCategories(params);
    return result.fold(
            (failure) => throw Exception(failure.message),
            (res) => res
    );
  }
  Future<UpdateCategoryRes> update(UpdateCategoryParam params, int id) async {
    final result = await repository.updateCategories(params, id);
    return result.fold(
            (failure) => throw Exception(failure.message),
            (res) => res
    );
  }
  Future<DeleteCategoryRes> delete(int id) async {
    final result = await repository.deleteCategories(id);
    return result.fold(
            (failure) => throw Exception(failure.message),
            (res) => res
    );
  }
}