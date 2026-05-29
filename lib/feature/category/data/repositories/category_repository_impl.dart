import 'package:dartz/dartz.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/data/data_state.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/error/failures.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_add_models/category_add_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/category_delete_model/category_delete_model.dart';
import 'package:lmhung_freshermb_getx_repo/feature/category/data/models/update_category_model/update_category_model.dart';

import '../../domain/entities/categories_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/remote/category_remote_data.dart';

class CategoryRepositoryImpl implements CategoriesRepository {
  final CategoryRemoteData remoteDataSource;

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
  Future<Either<Failure, CategoryAddRes>> addCategories(
    CategoryAddParams params,
  ) async {
    final result = await remoteDataSource.addCategories(params);
    if (result is DataSuccess) {
      return Right(result.data!);
    } else {
      final responseError = result.error;

      // Dịch ResponseError từ API thành ServerFailure
      return Left(
        Failure.serverFailure(
          message: responseError?.message ?? 'Lỗi không xác định',
          statusCode: responseError?.statusCode,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UpdateCategoryRes>> updateCategories(
    UpdateCategoryParam params,
    int id,
  ) async {
    final result = await remoteDataSource.updateCategories(params, id);
    if (result is DataSuccess) {
      return Right(result.data!);
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
  Future<Either<Failure, DeleteCategoryRes>> deleteCategories(int id) async {
    final result = await remoteDataSource.deleteCategories(id);
    if (result is DataSuccess) {
      return Right(result.data!);
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
