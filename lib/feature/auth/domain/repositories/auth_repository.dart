import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../entities/auth_token.dart';
import '../params/login_params.dart';
import '../params/register_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthToken>> login(LoginParams params);
  Future<Either<Failure, AuthToken>> register(RegisterParams params);

  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> logout();
}
