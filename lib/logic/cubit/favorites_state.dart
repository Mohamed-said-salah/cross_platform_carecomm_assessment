part of 'favorites_cubit.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  factory FavoritesState.initial() => FavoritesInitial();

  factory FavoritesState.loading() => FavoritesLoading();

  factory FavoritesState.loaded(List<ProductModel> products) =>
      FavoritesLoaded(products);

  factory FavoritesState.error() => FavoritesError();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<ProductModel> products;

  const FavoritesLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class FavoritesError extends FavoritesState {}
