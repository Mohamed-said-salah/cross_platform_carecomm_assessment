import 'dart:convert';

import 'package:cross_platform_product_listing_assessment/features/favorites/services/favorites_caching_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:cross_platform_product_listing_assessment/core/cache_manager.dart';
import 'package:cross_platform_product_listing_assessment/data/models/product_model.dart';
import 'package:cross_platform_product_listing_assessment/core/constants.dart';

// Generate a mock class for CacheManager
import 'favorites_caching_service_test.mocks.dart';

@GenerateMocks([CacheManager])
void main() {
  late FavoritesCachingService favoritesCachingService;
  late MockCacheManager mockCacheManager;

  setUp(() {
    mockCacheManager = MockCacheManager();
    favoritesCachingService = FavoritesCachingService(mockCacheManager);
  });

  group('FavoritesCachingService Tests', () {
    const String favoritesKey = Constants.favoritesKey;
    final product1 = ProductModel(id: 1, title: "Product 1");
    final product2 = ProductModel(id: 2, title: "Product 2");

    test('addFavoriteProduct should save product to cache', () async {
      // Arrange
      when(mockCacheManager.getString(favoritesKey)).thenReturn(null);
      when(mockCacheManager.setString(any, any)).thenAnswer((_) async => true);

      // Act
      final result = await favoritesCachingService.addFavoriteProduct(product1);

      // Assert
      expect(result, true);
      verify(mockCacheManager.setString(favoritesKey, any)).called(1);
    });

    test('getFavoriteProductById should return the correct product', () async {
      // Arrange
      final productsJson = jsonEncode([product1.toJson(), product2.toJson()]);
      when(mockCacheManager.getString(favoritesKey)).thenReturn(productsJson);

      // Act
      final result = await favoritesCachingService.getFavoriteProductById(2);

      // Assert
      expect(result?.id, 2);
      expect(result?.title, "Product 2");
    });

    test('getFavoriteProductById should return null if product not found',
        () async {
      // Arrange
      final productsJson = jsonEncode([product1.toJson()]);
      when(mockCacheManager.getString(favoritesKey)).thenReturn(productsJson);

      // Act
      final result = await favoritesCachingService.getFavoriteProductById(3);

      // Assert
      expect(result, isNull);
    });

    test('removeFavoriteProduct should remove product from cache', () async {
      // Arrange
      final productsJson = jsonEncode([product1.toJson(), product2.toJson()]);
      when(mockCacheManager.getString(favoritesKey)).thenReturn(productsJson);
      when(mockCacheManager.setString(any, any)).thenAnswer((_) async => true);

      // Act
      final result =
          await favoritesCachingService.removeFavoriteProduct(product1);

      // Assert
      expect(result, true);
      verify(mockCacheManager.setString(favoritesKey, any)).called(1);
    });

    test('removeFavoriteProduct should return false if cache is empty',
        () async {
      // Arrange
      when(mockCacheManager.getString(favoritesKey)).thenReturn(null);

      // Act
      final result =
          await favoritesCachingService.removeFavoriteProduct(product1);

      // Assert
      expect(result, false);
    });
  });
}
