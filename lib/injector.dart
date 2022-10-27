import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:web_scraping_task/product_details/data/data_sources/product_remote_data_source.dart';
import 'package:web_scraping_task/product_details/data/repositories/product_repository_impl.dart';
import 'package:web_scraping_task/product_details/domain/repositories/get_product_repository.dart';
import 'package:web_scraping_task/product_details/domain/use_cases/getAmazonPrice.dart';
import 'package:web_scraping_task/product_details/domain/use_cases/getJumiaPrice.dart';
import 'package:web_scraping_task/product_details/domain/use_cases/getPrice.dart';
import 'package:web_scraping_task/product_details/domain/use_cases/get_product.dart';
import 'package:web_scraping_task/product_details/presentation/cubit/product_cubit.dart';
import 'core/network_info/network_info.dart';
import 'package:http/http.dart' as http;


GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => ProductCubit(
      getProduct: sl(),
      getDp: sl(),
      getAmazon: sl(),
      getJumia: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetProduct(repository: sl()));
  sl.registerLazySingleton(() => GetDpPrice(repository: sl()));
  sl.registerLazySingleton(() => GetAmazonPrice(repository: sl()));
  sl.registerLazySingleton(() => GetJumiaPrice(repository: sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      networkInfo: sl(),
      productRemoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() =>http.Client());
}
