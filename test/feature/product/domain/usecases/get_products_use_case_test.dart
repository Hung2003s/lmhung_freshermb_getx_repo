import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lmhung_freshermb_getx_repo/core/network/error/failures.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/entities/product_entity.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/repositories/product_repository.dart';
import 'package:lmhung_freshermb_getx_repo/feature/product/domain/usecases/get_products_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProductsUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = GetProductsUseCase(mockRepository);
  });

  final tProducts = [
    const ProductEntity(id: 1, name: 'Product 1', price: 10000, stock: 10),
    const ProductEntity(id: 2, name: 'Product 2', price: 20000, stock: 20),
  ];

  group('GetProductsUseCase', () {
    test(
      'should return list of products when repository call is successful',
      () async {
        // Arrange
        when(
          () => mockRepository.getListProductById(
            keyword: any(named: 'keyword'),
            categoryId: any(named: 'categoryId'),
            page: any(named: 'page'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => Right(tProducts));

        // Act
        final result = await useCase(page: 1, limit: 20);

        // Assert
        expect(result, Right(tProducts));
        verify(
          () => mockRepository.getListProductById(
            keyword: null,
            categoryId: null,
            page: 1,
            limit: 20,
          ),
        ).called(1);
      },
    );

    test('should return ServerFailure when repository call fails', () async {
      // Arrange
      final tFailure = const ServerFailure(
        message: 'Server error',
        statusCode: 500,
      );
      when(
        () => mockRepository.getListProductById(
          keyword: any(named: 'keyword'),
          categoryId: any(named: 'categoryId'),
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await useCase(page: 1, limit: 20);

      // Assert
      expect(result, Left(tFailure));
    });

    test('should pass keyword and categoryId to repository', () async {
      // Arrange
      when(
        () => mockRepository.getListProductById(
          keyword: any(named: 'keyword'),
          categoryId: any(named: 'categoryId'),
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => Right(tProducts));

      // Act
      await useCase(keyword: 'test', categoryId: 1, page: 1, limit: 10);

      // Assert
      verify(
        () => mockRepository.getListProductById(
          keyword: 'test',
          categoryId: 1,
          page: 1,
          limit: 10,
        ),
      ).called(1);
    });

    test('should return empty list when no products found', () async {
      // Arrange
      when(
        () => mockRepository.getListProductById(
          keyword: any(named: 'keyword'),
          categoryId: any(named: 'categoryId'),
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => const Right(<ProductEntity>[]));

      // Act
      final result = await useCase(page: 1, limit: 20);

      // Assert
      expect(result, const Right(<ProductEntity>[]));
    });
  });
}
