import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/error/failures.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/repositories/product_repository.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/usecases/delete_product_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late DeleteProductUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = DeleteProductUseCase(mockRepository);
  });

  group('DeleteProductUseCase', () {
    test('should return true when delete is successful', () async {
      // Arrange
      when(
        () => mockRepository.deleteProduct(any()),
      ).thenAnswer((_) async => const Right(true));

      // Act
      final result = await useCase(1);

      // Assert
      expect(result, const Right(true));
      verify(() => mockRepository.deleteProduct(1)).called(1);
    });

    test('should return false when delete returns false', () async {
      // Arrange
      when(
        () => mockRepository.deleteProduct(any()),
      ).thenAnswer((_) async => const Right(false));

      // Act
      final result = await useCase(1);

      // Assert
      expect(result, const Right(false));
    });

    test('should return ServerFailure when delete fails', () async {
      // Arrange
      final tFailure = const ServerFailure(
        message: 'Delete failed',
        statusCode: 404,
      );
      when(
        () => mockRepository.deleteProduct(any()),
      ).thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await useCase(1);

      // Assert
      expect(result, Left(tFailure));
    });

    test('should pass correct id to repository', () async {
      // Arrange
      when(
        () => mockRepository.deleteProduct(any()),
      ).thenAnswer((_) async => const Right(true));

      // Act
      await useCase(42);

      // Assert
      verify(() => mockRepository.deleteProduct(42)).called(1);
    });
  });
}
