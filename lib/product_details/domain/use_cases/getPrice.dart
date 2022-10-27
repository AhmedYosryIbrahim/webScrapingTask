import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../entities/product.dart';
import '../repositories/get_product_repository.dart';

class GetDpPrice implements UseCase<Price, NoParams> {
  final ProductRepository repository;

  GetDpPrice({required this.repository});

  @override
  Future<Either<Failures, Price>> call(NoParams params) async {
    return await repository.getDpPrice();
  }
}