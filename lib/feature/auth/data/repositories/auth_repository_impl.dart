import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/data/data_state.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/storage/secure_storage/token/token_manager.dart';
import '../../domain/entities/auth_token.dart';
import '../../domain/params/login_params.dart';
import '../../domain/params/register_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_data_source.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../models/login_model/login_model.dart' as login_data;
import '../models/register_model/register_model.dart' as register_data;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final TokenManager tokenManager;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.tokenManager,
  });

  @override
  Future<Either<Failure, AuthToken>> login(LoginParams params) async {
    final dataParams = login_data.LoginParams(
      userName: params.userName,
      password: params.password,
    );
    final result = await remoteDataSource.login(dataParams);
    if (result is DataSuccess) {
      final authToken = result.data?.map(
        (model) => AuthToken(accessToken: model.data.accessToken),
      );
      final token = result.data?.data.accessToken;
      if (token != null) {
        await tokenManager.saveToken(token);
      }
      if (kDebugMode) {
        print("LoginRepositoryImpl saving token:: $token");
      }
      return Right(authToken!);
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
  Future<Either<Failure, AuthToken>> register(RegisterParams params) async {
    final dataParams = register_data.RegisterParams(
      userName: params.userName,
      password: params.password,
    );
    final result = await remoteDataSource.register(dataParams);
    if (result is DataSuccess) {
      final authToken = result.data?.map(
        (model) => AuthToken(accessToken: model.data.accessToken),
      );
      final token = result.data?.data.accessToken;
      if (token != null) {
        await tokenManager.saveToken(token);
      }
      if (kDebugMode) {
        print("LoginRepositoryImpl saving token:: $token");
      }
      return Right(authToken!);
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
