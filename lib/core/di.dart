import 'package:cross_platform_product_listing_assessment/core/services/cache_manager.dart';
import 'package:cross_platform_product_listing_assessment/data/repos/products_repo.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'services/favorites_caching_service.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // http client
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  // products repo
  getIt.registerLazySingleton<ProductsRepo>(
      () => ProductsRepo(getIt<http.Client>()));

  // shared prefs
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  // cache manager
  getIt.registerLazySingleton<CacheManager>(() => CacheManager(prefs));

  // favorites caching service
  getIt.registerLazySingleton<FavoritesCachingService>(
      () => FavoritesCachingService(getIt<CacheManager>()));
}
