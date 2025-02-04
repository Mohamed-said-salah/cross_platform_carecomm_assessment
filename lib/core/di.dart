import 'package:cross_platform_product_listing_assessment/data/repos/products_repo.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;

final GetIt getIt = GetIt.instance;

void setupGetIt() async {
  // http client
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  // products repo
  getIt.registerLazySingleton<ProductsRepo>(
      () => ProductsRepo(getIt<http.Client>()));
}
