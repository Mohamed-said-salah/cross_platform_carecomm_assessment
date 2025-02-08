import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cross_platform_product_listing_assessment/data/repos/products_repo.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo productsRepo;

  ProductsCubit(this.productsRepo) : super(ProductsState.initial());

  /// Emits a [ProductsState.loading] state and then either a
  /// [ProductsState.success] state or a [ProductsState.error] state,
  /// depending on the result of calling [productsRepo.getProducts].
  ///
  /// If [productsRepo.getProducts] returns a non-null value, it
  /// will be wrapped in a [ProductsState.success] state.
  ///
  /// If [productsRepo.getProducts] returns null, it will be wrapped
  /// in a [ProductsState.error] state.
  void emitProductsState() async {
    emit(ProductsState.loading());

    final result = await productsRepo.getProducts();

    if (result != null) {
      emit(ProductsState.success(result));
      return;
    }

    emit(ProductsState.error());
  }
}
