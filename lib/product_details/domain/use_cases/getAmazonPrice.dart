import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../entities/product.dart';
import '../repositories/get_product_repository.dart';

class GetAmazonPrice implements UseCase<Price, NoParams> {
  final ProductRepository repository;

  GetAmazonPrice({required this.repository});

  @override
  Future<Either<Failures, Price>> call(NoParams params) async {
    return await repository.getAmazonPrice();
  }
}