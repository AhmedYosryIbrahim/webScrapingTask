import 'package:dartz/dartz.dart';
import 'package:web_scraping_task/core/errors/failures.dart';
import 'package:web_scraping_task/core/network_info/network_info.dart';
import 'package:web_scraping_task/product_details/data/data_sources/product_remote_data_source.dart';
import 'package:web_scraping_task/product_details/domain/entities/product.dart';
import 'package:web_scraping_task/product_details/domain/repositories/get_product_repository.dart';

import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final NetworkInfo networkInfo;
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl(
      {required this.networkInfo, required this.productRemoteDataSource});

  @override
  Future<Either<Failures, Product>> getProduct() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await productRemoteDataSource.getProduct();
        return Right(remoteProduct);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failures, ProductPriceList>> getDpPrice() async {
    if (await networkInfo.isConnected) {
      try {
        final dpPrice = await productRemoteDataSource.getDpPrice();
        return Right(dpPrice);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failures, ProductPriceList>> getAmazonPrice() async {
    if (await networkInfo.isConnected) {
      try {
        final amazonPrice = await productRemoteDataSource.getAmazonPrice();
        return Right(amazonPrice);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failures, ProductPriceList>> getJumiaPrice() async {
    if (await networkInfo.isConnected) {
      try {
        final jumiaPrice = await productRemoteDataSource.getJumiaPrice();
        return Right(jumiaPrice);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
