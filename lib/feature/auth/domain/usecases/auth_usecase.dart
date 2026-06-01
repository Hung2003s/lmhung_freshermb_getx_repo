import '../entities/auth_token.dart';
import '../params/login_params.dart';
import '../params/register_params.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<AuthToken> call(LoginParams params) async {
    final result = await repository.login(params);
    return result.fold(
      (fail) => throw Exception(fail.message),
      (token) => token,
    );
  }

  Future<AuthToken> register(RegisterParams params) async {
    final result = await repository.register(params);
    return result.fold(
      (fail) => throw Exception(fail.message),
      (token) => token,
    );
  }
}

class CheckAuthStatusUseCase {
  final AuthRepository repository;
  CheckAuthStatusUseCase(this.repository);

  Future<bool> call() async {
    final token = await repository.getToken();
    return token != null && token.isNotEmpty;
  }
}
