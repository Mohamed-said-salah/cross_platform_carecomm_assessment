import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cross_platform_product_listing_assessment/logic/cubit/favorites_cubit.dart';
import 'package:cross_platform_product_listing_assessment/core/services/favorites_caching_service.dart';
import 'package:cross_platform_product_listing_assessment/data/models/product_model.dart';

import 'favorites_cubit_test.mocks.dart';

@GenerateMocks([FavoritesCachingService])
void main() {
  late FavoritesCubit favoritesCubit;
  late MockFavoritesCachingService mockFavoritesCachingService;

  setUp(() {
    mockFavoritesCachingService = MockFavoritesCachingService();
    favoritesCubit = FavoritesCubit(mockFavoritesCachingService);
  });

  tearDown(() {
    favoritesCubit.close();
  });

  group('FavoritesCubit Tests', () {
    final mockProduct = ProductModel(id: 1, title: "Product 1");
    final mockProductsList = [mockProduct];

    blocTest<FavoritesCubit, FavoritesState>(
      'emits [FavoritesLoading, FavoritesLoaded] when getFavorites succeeds',
      build: () {
        when(mockFavoritesCachingService.getFavoriteProductsFromCache())
            .thenAnswer((_) async => mockProductsList);
        return favoritesCubit;
      },
      act: (cubit) => cubit.getFavorites(),
      expect: () => [
        FavoritesLoading(),
        FavoritesLoaded(mockProductsList),
      ],
      verify: (_) {
        verify(mockFavoritesCachingService.getFavoriteProductsFromCache())
            .called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'emits [FavoritesLoading, FavoritesError] when getFavorites returns null',
      build: () {
        when(mockFavoritesCachingService.getFavoriteProductsFromCache())
            .thenAnswer((_) async => null);
        return favoritesCubit;
      },
      act: (cubit) => cubit.getFavorites(),
      expect: () => [
        FavoritesLoading(),
        FavoritesError(),
      ],
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'emits [FavoritesLoading, FavoritesLoaded] when addToFavorites succeeds',
      build: () {
        when(mockFavoritesCachingService.addFavoriteProduct(mockProduct))
            .thenAnswer((_) async => true);
        when(mockFavoritesCachingService.getFavoriteProductsFromCache())
            .thenAnswer((_) async => mockProductsList);
        return favoritesCubit;
      },
      act: (cubit) => cubit.addToFavorites(mockProduct),
      expect: () => [
        FavoritesLoading(),
        FavoritesLoaded(mockProductsList),
      ],
      verify: (_) {
        verify(mockFavoritesCachingService.addFavoriteProduct(mockProduct))
            .called(1);
      },
    );

    blocTest<FavoritesCubit, FavoritesState>(
      'emits [FavoritesLoading, FavoritesLoaded] when removeFromFavorites succeeds',
      build: () {
        when(mockFavoritesCachingService.removeFavoriteProduct(mockProduct))
            .thenAnswer((_) async => true);
        when(mockFavoritesCachingService.getFavoriteProductsFromCache())
            .thenAnswer((_) async => []);
        return favoritesCubit;
      },
      act: (cubit) => cubit.removeFromFavorites(mockProduct),
      expect: () => [
        FavoritesLoading(),
        FavoritesLoaded([]),
      ],
      verify: (_) {
        verify(mockFavoritesCachingService.removeFavoriteProduct(mockProduct))
            .called(1);
      },
    );
  });
}
