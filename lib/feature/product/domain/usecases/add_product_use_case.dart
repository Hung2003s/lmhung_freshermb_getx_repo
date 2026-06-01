import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../params/product_params.dart';
import '../repositories/product_repository.dart';

class AddProductUseCase {
  final ProductRepository repository;

  AddProductUseCase(this.repository);

  Future<Either<Failure, int>> call(ProductInfoParam params) async {
    return repository.addProduct(params);
  }
}
