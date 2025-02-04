import 'dart:convert';

import 'package:cross_platform_product_listing_assessment/core/cache_manager.dart';

import 'package:cross_platform_product_listing_assessment/data/models/product_model.dart';

import '../../../core/constants.dart';

class FavoritesCachingService {
  final CacheManager cacheManager;

  FavoritesCachingService(this.cacheManager);

  /// Writes the given list of favorite products to the cache.
  ///
  /// Converts the list of products to a JSON string and saves it in the cache
  /// using the key [Constants.favoritesKey].
  ///
  /// Returns a `Future` containing a boolean indicating whether the write was
  /// successful.
  Future<bool> _writeFavoriteProductsToCache(
      List<ProductModel> products) async {
    List<Map<String, dynamic>> productsMap =
        products.map((product) => product.toJson()).toList();

    String productsJson = jsonEncode(productsMap);

    return await cacheManager.setString(Constants.favoritesKey, productsJson);
  }

  /// Reads the cached list of favorite products from the cache.
  ///
  /// Returns a `Future` containing the list of favorite products, or `null` if
  /// the cache is empty.
  Future<List<ProductModel>?> _readFavoriteProductsFromCache() async {
    String? productsJson = cacheManager.getString(Constants.favoritesKey);
    if (productsJson == null) {
      return null;
    }

    List<Map<String, dynamic>> productsMap =
        jsonDecode(productsJson) as List<Map<String, dynamic>>;

    List<ProductModel> products =
        productsMap.map((product) => ProductModel.fromJson(product)).toList();

    return products;
  }

  /// Adds the given product to the list of favorite products in the cache.
  ///
  /// Retrieves the current list of favorite products from the cache, adds the
  /// given product to it, and writes the updated list back to the cache.
  ///
  /// Returns a `Future` containing a boolean indicating whether the write was
  /// successful.
  Future<bool> addFavoriteProduct(ProductModel product) async {
    List<ProductModel>? products = await _readFavoriteProductsFromCache();

    products ??= [];

    products.add(product);

    return _writeFavoriteProductsToCache(products);
  }

  /// Retrieves a favorite product by its ID from the cache.
  ///
  /// Returns a `Future` containing the favorite product with the given ID, or
  /// `null` if the cache is empty or no product with the given ID is found.
  Future<ProductModel?> getFavoriteProductById(int productId) async {
    List<ProductModel?>? products = await _readFavoriteProductsFromCache();

    if (products == null) {
      return null;
    }

    return products.firstWhere((p) => p?.id == productId, orElse: () => null);
  }

  /// Removes the given product from the list of favorite products in the cache.
  ///
  /// Retrieves the current list of favorite products from the cache, removes the
  /// given product from it, and writes the updated list back to the cache.
  ///
  /// Returns a `Future` containing a boolean indicating whether the write was
  /// successful.
  Future<bool> removeFavoriteProduct(ProductModel product) async {
    List<ProductModel>? products = await _readFavoriteProductsFromCache();

    if (products == null) {
      return false;
    }

    products.removeWhere((p) => p.id == product.id);

    return _writeFavoriteProductsToCache(products);
  }
}
