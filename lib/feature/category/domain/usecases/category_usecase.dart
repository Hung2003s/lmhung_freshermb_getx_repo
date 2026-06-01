import '../entities/categories_entity.dart';
import '../params/add_category_params.dart';
import '../params/update_category_params.dart';
import '../repositories/categories_repository.dart';

class CategoryUseCase {
  final CategoriesRepository repository;

  CategoryUseCase(this.repository);

  Future<List<CategoryEntity>> call({int page = 1, int limit = 20}) async {
    final result = await repository.getCategories(page: page, limit: limit);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (list) => list,
    );
  }

  Future<int> add(AddCategoryParams params) async {
    final result = await repository.addCategories(params);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (res) => res,
    );
  }

  Future<bool> update(UpdateCategoryParams params, int id) async {
    final result = await repository.updateCategories(params, id);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (res) => res,
    );
  }

  Future<bool> delete(int id) async {
    final result = await repository.deleteCategories(id);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (res) => res,
    );
  }
}
