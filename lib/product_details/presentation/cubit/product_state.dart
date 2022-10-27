part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final Product product;

  ProductLoaded({required this.product});
}

class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});
}

class PriceLoading extends ProductState {}

class PriceLoaded extends ProductState {
  final List<Price> priceList;

  PriceLoaded({required this.priceList});
}

class PriceError extends ProductState {
  final String message;

  PriceError({required this.message});
}