import 'package:dartz/dartz.dart';
import 'package:web_scraping_task/product_details/data/models/product_model.dart';

import '../../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failures, Product>> getProduct();
  Future<Either<Failures, ProductPriceList>> getDpPrice();
  Future<Either<Failures, ProductPriceList>> getAmazonPrice();
  Future<Either<Failures, ProductPriceList>> getJumiaPrice();
}