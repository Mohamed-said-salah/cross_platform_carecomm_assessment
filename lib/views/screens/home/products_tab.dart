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

    // <--- Emit the at first products state to load the products.
    getIt<ProductsCubit>().emitProductsState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      bloc: getIt<ProductsCubit>(),
      builder: (context, state) {
        // <--- Display a loading indicator if the state is a loading.
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // <--- Display the products list if the state is a success.
        if (state is ProductsSuccess) {
          return LayoutBuilder(builder: (context, constraints) {
            // <--- Display a mobile-friendly [ListView] for the products list.
            if (constraints.maxWidth < 800) {
              return _mobileListView(state);
              // <--- Display a tablet-friendly [GridView] for the products list.
            } else if (constraints.maxWidth < 1200) {
              return _tabletView(state);
              // <--- Display a desktop-friendly [GridView] for the products list.
            } else {
              return _desktopView(state);
            }
          });
        }
        // <--- Display an error message if the state is an error.
        return const Center(child: Text("Something went wrong"));
      },
    );
  }

  /// Builds a mobile-friendly [ListView] for the products list.
  ///
  /// The [ListView] is separated by a [Divider] and each item is a
  /// [ProductTile] with the corresponding product.
  ///
  /// The [BouncingScrollPhysics] is used to provide a bouncing effect
  /// when scrolling to the end of the list.
  ListView _mobileListView(ProductsSuccess state) {
    // <--- Build a mobile-friendly [ListView] for the products list.
    return ListView.separated(
      // <--- Set the physics for the [ListView] to BouncingScrollPhysics.
      physics: const BouncingScrollPhysics(),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        // <--- Return a [ProductTile] with the corresponding product.
        return ProductTile(product: state.products[index]);
      },
      // <--- Add a [Divider] between each item.
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  GridView _tabletView(ProductsSuccess state) {
    // <--- Build a tablet-friendly [GridView] for the products list.
    return GridView.builder(
      // <--- Set the padding and grid delegate for the [GridView].
      padding: EdgeInsets.only(top: 5.w, right: 10.w, left: 10.w),
      // <--- Set the cross axis count, main axis spacing, cross axis spacing, and child aspect ratio.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.14,
      ),
      // <--- Set the item count and builder for the [GridView].
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        // <--- Return a [ProductCard] with the corresponding product.
        return ProductCard(product: state.products[index]);
      },
    );
  }

  /// Builds a desktop-friendly [GridView] for the products list.
  ///
  /// The [GridView] has a padding of 5 logical pixels on the top, 10 logical
  /// pixels on the right and left, and a cross axis count of 3. The main axis
  /// spacing is 20 logical pixels, cross axis spacing is 20 logical pixels, and
  /// the child aspect ratio is 1.115. The item count is the length of the
  /// [products] list, and the itemBuilder returns a [ProductCard] with the
  /// corresponding product.
  GridView _desktopView(ProductsSuccess state) {
    // <--- Build a desktop-friendly [GridView] for the products list.
    return GridView.builder(
      // <--- Set the padding and grid delegate for the [GridView].
      padding: EdgeInsets.only(top: 5.w, right: 10.w, left: 10.w),
      // <--- Set the cross axis count, main axis spacing, cross axis spacing, and child aspect ratio.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.115,
      ),
      // <--- Set the item count and builder for the [GridView].
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        // <--- Return a [ProductCard] with the corresponding product.
        return ProductCard(product: state.products[index]);
      },
    );
  }
}
