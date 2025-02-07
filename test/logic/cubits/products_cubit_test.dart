import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:cross_platform_product_listing_assessment/logic/cubit/products_cubit.dart';
import 'package:cross_platform_product_listing_assessment/data/repos/products_repo.dart';
import 'package:cross_platform_product_listing_assessment/data/models/product_model.dart';

import 'products_cubit_test.mocks.dart';

@GenerateMocks([ProductsRepo])
void main() {
  late ProductsCubit productsCubit;
  late MockProductsRepo mockProductsRepo;

  setUp(() {
    mockProductsRepo = MockProductsRepo();
    productsCubit = ProductsCubit(mockProductsRepo);
  });

  tearDown(() {
    productsCubit.close();
  });

  group('ProductsCubit Tests', () {
    final mockProducts = [
      ProductModel(id: 1, title: "Product 1"),
      ProductModel(id: 2, title: "Product 2"),
    ];

    blocTest<ProductsCubit, ProductsState>(
      'emits [ProductsLoading, ProductsSuccess] when fetch is successful',
      build: () {
        when(mockProductsRepo.getProducts())
            .thenAnswer((_) async => mockProducts);
        return productsCubit;
      },
      act: (cubit) => cubit.emitProductsState(),
      expect: () => [
        ProductsLoading(),
        ProductsSuccess(mockProducts),
      ],
      verify: (_) {
        verify(mockProductsRepo.getProducts()).called(1);
      },
    );

    blocTest<ProductsCubit, ProductsState>(
      'emits [ProductsLoading, ProductsError] when fetch fails',
      build: () {
        when(mockProductsRepo.getProducts()).thenAnswer((_) async => null);
        return productsCubit;
      },
      act: (cubit) => cubit.emitProductsState(),
      expect: () => [
        ProductsLoading(),
        ProductsError(),
      ],
      verify: (_) {
        verify(mockProductsRepo.getProducts()).called(1);
      },
    );
  });
}
