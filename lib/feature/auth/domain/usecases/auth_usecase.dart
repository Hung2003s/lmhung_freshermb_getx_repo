import 'package:dartz/dartz.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/error/failures.dart';
import 'package:lmhung_freshermb_getx_repo/core/storage/secure_storage/token/token_manager.dart';
import '../entities/auth_token.dart';
import '../params/login_params.dart';
import '../params/register_params.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<Either<Failure, AuthToken>> call(LoginParams params) async {
    return repository.login(params);
  }

  Future<Either<Failure, AuthToken>> register(RegisterParams params) async {
    return repository.register(params);
  }
}

class CheckAuthStatusUseCase {
  final TokenManager tokenManager;
  CheckAuthStatusUseCase(this.tokenManager);

  Future<bool> call() async {
    final token = await tokenManager.getToken();
    return token != null && token.isNotEmpty;
  }
}
