import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_scraping_task/product_details/domain/use_cases/getJumiaPrice.dart';
import 'package:web_scraping_task/product_details/domain/use_cases/getPrice.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecases.dart';
import '../../../core/utils/app_strings.dart';
import '../../domain/entities/product.dart';
import '../../domain/use_cases/getAmazonPrice.dart';
import '../../domain/use_cases/get_product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProduct getProduct;
  final GetDpPrice getDp;
  final GetAmazonPrice getAmazon;
  final GetJumiaPrice getJumia;

  ProductCubit(
      {required this.getProduct,
      required this.getDp,
      required this.getAmazon,
      required this.getJumia})
      : super(ProductInitial());

  List<Price> priceList = [];
// sort price list by price in ascending order
  void sortPriceList() {
    priceList.sort((a, b) => a.price.compareTo(b.price));
  }

  late Product product;

  void getProductDetails() async {
    emit(ProductLoading());
    final product = await getProduct(NoParams());
    product.fold(
      (failure) => emit(ProductError(message: _failureToString(failure))),
      (product) {
        this.product = product;
        emit(ProductLoaded(product: product));
      },
    );
  }

  void getDpPrice() async {
    emit(PriceLoading());
    final dpPrice = await getDp(NoParams());
    dpPrice.fold(
      (failure) => emit(PriceError(message: _failureToString(failure))),
      (dpPrice) {
        priceList.add(dpPrice);
        sortPriceList();
        emit(PriceLoaded(priceList: priceList));
      },
    );
  }

  void getAmazonPrice() async {
    emit(PriceLoading());
    final amazonPrice = await getAmazon(NoParams());
    amazonPrice.fold(
      (failure) => emit(PriceError(message: _failureToString(failure))),
      (amazonPrice) {
        priceList.add(amazonPrice);
        sortPriceList();
        emit(PriceLoaded(priceList: priceList));
      },
    );
  }

  void getJumiaPrice() async {
    emit(PriceLoading());
    final jumiaPrice = await getJumia(NoParams());
    jumiaPrice.fold(
      (failure) => emit(PriceError(message: _failureToString(failure))),
      (jumiaPrice) {
        priceList.add(jumiaPrice);
        sortPriceList();
        emit(PriceLoaded(priceList: priceList));
      },
    );
  }

  String _failureToString(Failures failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailureMessage;
      default:
        return AppStrings.unexpectedErrorMessage;
    }
  }
}
