import 'package:dartz/dartz.dart';

import '../../../../core/network/error/failures.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  Future<Either<Failure, bool>> call(int id) async {
    return repository.deleteProduct(id);
  }
}
