import 'package:dartz/dartz.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/error/failures.dart';

import '../../../../core/network/data/data_state.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/params/product_params.dart';
import '../../domain/repository/product_repository.dart';
import '../datasources/remote/product_remote_data_source.dart';
import '../model/product_model.dart' as data;

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getListProductById({
    String? keyword,
    int? categoryId,
    required int page,
    required int limit,
  }) async {
    final result = await remoteDataSource.getListProductById(
      keyword: keyword,
      categoryId: categoryId,
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
  Future<Either<Failure, int>> addProduct(ProductInfoParam params) async {
    final dataParams = data.ProductInfoParam(
      name: params.name,
      code: params.code,
      price: params.price,
      stock: params.stock,
      category: params.category,
      description: params.description,
      image: params.image,
    );
    final result = await remoteDataSource.addProduct(params: dataParams);
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
  Future<Either<Failure, bool>> deleteProduct(int id) async {
    final result = await remoteDataSource.deleteProduct(id: id);
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
  Future<Either<Failure, bool>> updateProduct(
    ProductInfoParam params,
    int id,
  ) async {
    final dataParams = data.ProductInfoParam(
      name: params.name,
      code: params.code,
      price: params.price,
      stock: params.stock,
      category: params.category,
      description: params.description,
      image: params.image,
    );
    final result = await remoteDataSource.updateProduct(
      params: dataParams,
      id: id,
    );
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
