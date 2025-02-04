import 'package:cross_platform_product_listing_assessment/data/repos/products_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import 'package:cross_platform_product_listing_assessment/core/constants.dart';

// Generate mock class using annotation
import 'product_repo_test.mocks.dart';

@GenerateMocks([http.Client])

/// Runs tests for [ProductsRepo].
///
/// It tests the following cases:
/// 1. If the response status is 200, it returns a list of [ProductModel].
/// 2. If the response status is not 200, it returns null.
/// 3. If an exception occurs, it returns null.
void main() {
  late ProductsRepo productsRepo;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    productsRepo = ProductsRepo(mockClient);
  });

  group('getProducts', () {
    test('returns list of ProductModel if response is 200', () async {
      final fakeResponse = '''
        [
          {
            "id": 1,
            "title": "Test Product",
            "price": 100,
            "description": "A test product",
            "category": "test",
            "image": "https://example.com/image.jpg",
            "rating": {"rate": 4.5, "count": 10}
          }
        ]
      ''';

      when(mockClient.get(Uri.parse('${Constants.baseUrl}/products')))
          .thenAnswer((_) async => http.Response(fakeResponse, 200));

      final products = await productsRepo.getProducts();

      expect(products, isNotNull);
      expect(products!.length, 1);
      expect(products[0].id, 1);
      expect(products[0].title, "Test Product");
    });

    test('returns null if response is not 200', () async {
      when(mockClient.get(Uri.parse('${Constants.baseUrl}/products')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final products = await productsRepo.getProducts();

      expect(products, isNull);
    });

    test('returns null on exception', () async {
      when(mockClient.get(Uri.parse('${Constants.baseUrl}/products')))
          .thenThrow(Exception("Network error"));

      final products = await productsRepo.getProducts();

      expect(products, isNull);
    });
  });
}
