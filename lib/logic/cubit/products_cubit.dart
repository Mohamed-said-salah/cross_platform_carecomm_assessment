import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cross_platform_product_listing_assessment/data/repos/products_repo.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo productsRepo;

  ProductsCubit(this.productsRepo) : super(ProductsState.initial());

  void emitProductsState() async {
    emit(ProductsState.loading());

    final result = await productsRepo.getProducts();

    if (result != null) {
      emit(ProductsState.success(result));
    }

    emit(ProductsState.error());
  }
}
