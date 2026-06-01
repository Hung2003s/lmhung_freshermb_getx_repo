import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/data/data_state.dart';
import '../../../../core/network/error/failures.dart';
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

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  String? _cachedToken;
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
      _cachedToken = result.data?.data.accessToken;
      await localDataSource.saveToken(_cachedToken!);
      if (kDebugMode) {
        print("LoginRepositoryImpl saving token:: $_cachedToken");
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
  Future<String?> getToken() async {
    if (_cachedToken != null) return _cachedToken;
    _cachedToken = await localDataSource.getToken();
    return _cachedToken;
  }

  @override
  Future<void> logout() async {
    _cachedToken = null;
    await localDataSource.clearToken();
  }

  @override
  Future<void> saveToken(String token) async {
    _cachedToken = token;
    await localDataSource.saveToken(token);
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
      _cachedToken = result.data?.data.accessToken;
      await localDataSource.saveToken(_cachedToken!);
      if (kDebugMode) {
        print("LoginRepositoryImpl saving token:: $_cachedToken");
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
