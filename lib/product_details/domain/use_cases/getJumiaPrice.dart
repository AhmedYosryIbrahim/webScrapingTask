import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../entities/product.dart';
import '../repositories/get_product_repository.dart';

class GetJumiaPrice implements UseCase<Price, NoParams> {
  final ProductRepository repository;

  GetJumiaPrice({required this.repository});

  @override
  Future<Either<Failures, Price>> call(NoParams params) async {
    return await repository.getJumiaPrice();
  }
}