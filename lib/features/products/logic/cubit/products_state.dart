part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  factory ProductsState.initial() => ProductsInitial();

  factory ProductsState.loading() => ProductsLoading();

  factory ProductsState.success(List<ProductModel> products) =>
      ProductsSuccess(products);

  factory ProductsState.error() => ProductsError();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<ProductModel> products;

  const ProductsSuccess(this.products);

  @override
  List<Object> get props => [products];
}

final class ProductsError extends ProductsState {}
