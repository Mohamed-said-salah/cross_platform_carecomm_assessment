import 'package:cross_platform_product_listing_assessment/core/di.dart';
import 'package:cross_platform_product_listing_assessment/logic/cubit/products_cubit.dart';
import 'package:cross_platform_product_listing_assessment/views/components/cards/product_card.dart';
import 'package:cross_platform_product_listing_assessment/views/components/tiles/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  @override
  void initState() {
    super.initState();

    getIt<ProductsCubit>().emitProductsState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      bloc: getIt<ProductsCubit>(),
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductsSuccess) {
          return LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < 800) {
              return _mobileListView(state);
            } else if (constraints.maxWidth < 1200) {
              return _tabletView(state);
            } else {
              return _desktopView(state);
            }
          });
        }

        return const Center(child: Text("Something went wrong"));
      },
    );
  }

  ListView _mobileListView(ProductsSuccess state) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        return ProductTile(product: state.products[index]);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  GridView _tabletView(ProductsSuccess state) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 5.w, right: 10.w, left: 10.w),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.14,
      ),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: state.products[index]);
      },
    );
  }

  GridView _desktopView(ProductsSuccess state) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 5.w, right: 10.w, left: 10.w),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.115,
      ),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: state.products[index]);
      },
    );
  }
}
