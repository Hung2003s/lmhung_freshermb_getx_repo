import 'package:dartz/dartz.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/data/models/register_model/register_model.dart';

import '../../../../core/network/error/failures.dart';
import '../../data/models/login_model/login_model.dart';
import '../../domain/entities/auth_token.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthToken>> login(LoginParams params);
  Future<Either<Failure, AuthToken>> register(RegisterParams params);

  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> logout();
}
