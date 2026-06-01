import 'package:dartz/dartz.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/data/data_state.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/error/failures.dart';

import '../../domain/entities/categories_entity.dart';
import '../../domain/params/add_category_params.dart';
import '../../domain/params/update_category_params.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/remote/category_remote_data.dart';
import '../models/category_add_models/category_add_model.dart' as add_data;
import '../models/update_category_model/update_category_model.dart'
    as update_data;

class CategoryRepositoryImpl implements CategoriesRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    int page = 1,
    int limit = 20,
  }) async {
    final result = await remoteDataSource.getCategories(
      page: page,
      limit: limit,
    );
    if (result is DataSuccess) {
      return Right(result.data!.responseToListEntities());
    } else {
      final responseError = result.error;

      return Left(
        Failure.serverFailure(
          message: responseError?.message ?? 'Lỗi không xác định',
          statusCode: responseError?.statusCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> addCategories(AddCategoryParams params) async {
    final dataParams = add_data.CategoryAddParams(name: params.name);
    final result = await remoteDataSource.addCategories(dataParams);
    if (result is DataSuccess) {
      return Right(result.data!.data);
    } else {
      final responseError = result.error;
      return Left(
        Failure.serverFailure(
          message: responseError?.message ?? 'Lỗi không xác định',
          statusCode: responseError?.statusCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> updateCategories(
    UpdateCategoryParams params,
    int id,
  ) async {
    final dataParams = update_data.UpdateCategoryParam(name: params.name);
    final result = await remoteDataSource.updateCategories(dataParams, id);
    if (result is DataSuccess) {
      return Right(result.data!.data);
    } else {
      final responseError = result.error;
      return Left(
        Failure.serverFailure(
          message: responseError?.message ?? 'Lỗi không xác định',
          statusCode: responseError?.statusCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCategories(int id) async {
    final result = await remoteDataSource.deleteCategories(id);
    if (result is DataSuccess) {
      return Right(result.data!.data);
    } else {
      final responseError = result.error;
      return Left(
        Failure.serverFailure(
          message: responseError?.message ?? 'Lỗi không xác định',
          statusCode: responseError?.statusCode,
        ),
      );
    }
  }
}
