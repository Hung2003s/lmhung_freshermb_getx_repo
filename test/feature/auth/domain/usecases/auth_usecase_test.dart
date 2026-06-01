import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/error/failures.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/domain/entities/auth_token.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/domain/params/login_params.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/domain/params/register_params.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/domain/repositories/auth_repository.dart';
import 'package:lmhung_freshermb_getx_repo/feature/auth/domain/usecases/auth_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthUseCase useCase;
  late MockAuthRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(const LoginParams(userName: '', password: ''));
    registerFallbackValue(const RegisterParams(userName: '', password: ''));
  });

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = AuthUseCase(mockRepository);
  });

  final tLoginParams = const LoginParams(
    userName: 'testuser',
    password: 'password123',
  );

  final tRegisterParams = const RegisterParams(
    userName: 'newuser',
    password: 'newpassword123',
  );

  final tAuthToken = const AuthToken(accessToken: 'test_access_token');

  group('AuthUseCase - Login', () {
    test('should return AuthToken when login is successful', () async {
      // Arrange
      when(
        () => mockRepository.login(any()),
      ).thenAnswer((_) async => Right(tAuthToken));

      // Act
      final result = await useCase(tLoginParams);

      // Assert
      expect(result, Right(tAuthToken));
      verify(() => mockRepository.login(tLoginParams)).called(1);
    });

    test('should return ServerFailure when login fails', () async {
      // Arrange
      const tFailure = ServerFailure(
        message: 'Invalid credentials',
        statusCode: 401,
      );
      when(
        () => mockRepository.login(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(tLoginParams);

      // Assert
      expect(result, const Left(tFailure));
    });

    test('should pass correct login params to repository', () async {
      // Arrange
      when(
        () => mockRepository.login(any()),
      ).thenAnswer((_) async => Right(tAuthToken));

      // Act
      await useCase(tLoginParams);

      // Assert
      verify(() => mockRepository.login(tLoginParams)).called(1);
    });
  });

  group('AuthUseCase - Register', () {
    test('should return AuthToken when register is successful', () async {
      // Arrange
      when(
        () => mockRepository.register(any()),
      ).thenAnswer((_) async => Right(tAuthToken));

      // Act
      final result = await useCase.register(tRegisterParams);

      // Assert
      expect(result, Right(tAuthToken));
      verify(() => mockRepository.register(tRegisterParams)).called(1);
    });

    test('should return ServerFailure when register fails', () async {
      // Arrange
      const tFailure = ServerFailure(
        message: 'Username already exists',
        statusCode: 409,
      );
      when(
        () => mockRepository.register(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase.register(tRegisterParams);

      // Assert
      expect(result, const Left(tFailure));
    });

    test('should pass correct register params to repository', () async {
      // Arrange
      when(
        () => mockRepository.register(any()),
      ).thenAnswer((_) async => Right(tAuthToken));

      // Act
      await useCase.register(tRegisterParams);

      // Assert
      verify(() => mockRepository.register(tRegisterParams)).called(1);
    });
  });
}
