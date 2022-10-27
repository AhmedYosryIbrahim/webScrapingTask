import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../entities/product.dart';
import '../repositories/get_product_repository.dart';

class GetProduct implements UseCase<Product, NoParams> {
  final ProductRepository repository;

  GetProduct({required this.repository});

  @override
  Future<Either<Failures, Product>> call(NoParams params) async {
    return await repository.getProduct();
  }
}

