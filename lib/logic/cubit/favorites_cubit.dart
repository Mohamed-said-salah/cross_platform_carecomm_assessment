import 'package:cross_platform_product_listing_assessment/core/services/favorites_caching_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cross_platform_product_listing_assessment/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesCachingService favoritesCachingService;

  FavoritesCubit(this.favoritesCachingService)
      : super(FavoritesState.initial());

  /// Fetches the list of favorite products from the cache.
  ///
  /// Emits a [FavoritesState.loading] state while fetching.
  /// If favorite products are found, emits a [FavoritesState.loaded] state
  /// with the list of products. If no products are found or an error occurs,
  /// emits a [FavoritesState.error] state.

  void getFavorites() async {
    emit(FavoritesState.loading());

    final favoriteProducts =
        await favoritesCachingService.getFavoriteProductsFromCache();

    if (favoriteProducts != null) {
      emit(FavoritesState.loaded(favoriteProducts));

      return;
    }

    emit(FavoritesState.error());
  }

  /// Adds a product to the list of favorite products.
  ///
  /// Emits a [FavoritesState.loading] state while adding.
  /// Calls the [FavoritesCachingService.addFavoriteProduct] to add the product
  /// to the cache, then refreshes the list of favorite products by calling
  /// [getFavorites].

  void addToFavorites(ProductModel product) async {
    emit(FavoritesState.loading());

    final result = await favoritesCachingService.addFavoriteProduct(product);

    if (result) getFavorites();
  }

  /// Removes a product from the list of favorite products.
  ///
  /// Emits a [FavoritesState.loading] state while removing.
  /// Calls the [FavoritesCachingService.removeFavoriteProduct] to remove the
  /// product from the cache, then refreshes the list of favorite products by
  /// calling [getFavorites].
  void removeFromFavorites(ProductModel product) async {
    emit(FavoritesState.loading());

    final result = await favoritesCachingService.removeFavoriteProduct(product);

    if (result) getFavorites();
  }
}
