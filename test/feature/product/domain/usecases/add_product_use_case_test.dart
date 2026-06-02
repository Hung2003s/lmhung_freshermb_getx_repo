import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/error/failures.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/params/product_params.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/repositories/product_repository.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/usecases/add_product_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late AddProductUseCase useCase;
  late MockProductRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(const ProductInfoParam(name: '', code: ''));
  });

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = AddProductUseCase(mockRepository);
  });

  final tParams = const ProductInfoParam(
    name: 'Test Product',
    code: 'TP001',
    price: 15000,
    stock: 50,
    category: 1,
    description: 'Test description',
  );

  group('AddProductUseCase', () {
    test('should return new product id when add is successful', () async {
      // Arrange
      when(
        () => mockRepository.addProduct(any()),
      ).thenAnswer((_) async => const Right(1));

      // Act
      final result = await useCase(tParams);

      // Assert
      expect(result, const Right(1));
      verify(() => mockRepository.addProduct(tParams)).called(1);
    });

    test('should return ServerFailure when add fails', () async {
      // Arrange
      const tFailure = ServerFailure(message: 'Add failed', statusCode: 400);
      when(
        () => mockRepository.addProduct(any()),
      ).thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(tParams);

      // Assert
      expect(result, const Left(tFailure));
    });

    test('should pass correct params to repository', () async {
      // Arrange
      when(
        () => mockRepository.addProduct(any()),
      ).thenAnswer((_) async => const Right(1));

      // Act
      await useCase(tParams);

      // Assert
      verify(() => mockRepository.addProduct(tParams)).called(1);
    });
  });
}
