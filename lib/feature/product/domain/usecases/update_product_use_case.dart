import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../params/product_params.dart';
import '../repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository repository;

  UpdateProductUseCase(this.repository);

  Future<Either<Failure, bool>> call(ProductInfoParam params, int id) async {
    return repository.updateProduct(params, id);
  }
}
