import 'package:cross_platform_product_listing_assessment/core/di.dart';
import 'package:cross_platform_product_listing_assessment/views/components/cards/product_card.dart';
import 'package:cross_platform_product_listing_assessment/views/components/tiles/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../logic/cubit/favorites_cubit.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  void initState() {
    super.initState();

    // <--- Emit the at first products state to load the products --->
    getIt<FavoritesCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      bloc: getIt<FavoritesCubit>(),
      builder: (context, state) {
        // <--- Display a loading indicator if the state is [FavoritesLoading] --->
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // <--- Display the products list if the state is [FavoritesLoaded] --->
        if (state is FavoritesLoaded) {
          return LayoutBuilder(builder: (context, constraints) {
            // <--- Determine the layout based on the screen size --->
            // <--- Display a mobile-friendly [ListView] for the products list.
            if (constraints.maxWidth < 800) {
              return _mobileListView(state);

              // <--- Determine the layout based on the screen size --->
            } else if (constraints.maxWidth < 1200) {
              return _tabletView(state);

              // <--- Determine the layout based on the screen size --->
            } else {
              return _desktopView(state);
            }
          });
        }

        // <--- Display an error message if the state is [FavoritesError] --->
        return const Center(child: Text("Nothing to show"));
      },
    );
  }

  /// Builds a mobile-friendly [ListView] for the products list.
  ///
  /// The [ListView] has a bouncing physics and a divider between each item.
  /// The item count is the length of the [products] list, and the itemBuilder
  /// returns a [ProductTile] with the corresponding product.
  ListView _mobileListView(FavoritesLoaded state) {
    // <--- Build a mobile-friendly [ListView] for the products list --->
    return ListView.separated(
      // <--- Set the physics for the [ListView] to BouncingScrollPhysics --->
      physics: const BouncingScrollPhysics(),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        // <--- Return a [ProductTile] with the corresponding product --->
        return ProductTile(product: state.products[index]);
      },

      // <--- Add a [Divider] between each item --->
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  /// Builds a tablet-friendly [GridView] for the products list.
  ///
  /// The [GridView] has a padding of 5 logical pixels on the top, 10 logical
  /// pixels on the right and left, and a cross axis count of 2. The main axis
  /// spacing is 20 logical pixels, cross axis spacing is 20 logical pixels, and
  /// the child aspect ratio is 1.14. The item count is the length of the
  /// [products] list, and the itemBuilder returns a [ProductCard] with the
  /// corresponding product.
  GridView _tabletView(FavoritesLoaded state) {
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

  /// Builds a desktop-friendly [GridView] for the products list.
  ///
  /// The [GridView] has a padding of 5 logical pixels on the top, 10 logical
  /// pixels on the right and left, and a cross axis count of 3. The main axis
  /// spacing is 20 logical pixels, cross axis spacing is 20 logical pixels, and
  /// the child aspect ratio is 1.115. The item count is the length of the
  /// [products] list, and the itemBuilder returns a [ProductCard] with the
  /// corresponding product.
  GridView _desktopView(FavoritesLoaded state) {
    // <--- Build a desktop-friendly [GridView] for the products list --->
    return GridView.builder(
      // <--- Set the padding and grid delegate for the [GridView] --->
      padding: EdgeInsets.only(top: 5.w, right: 10.w, left: 10.w),
      // <--- Set the cross axis count, main axis spacing, cross axis spacing, and child aspect ratio --->
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.115,
      ),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        // <--- Return a [ProductCard] with the corresponding product --->
        return ProductCard(product: state.products[index]);
      },
    );
  }
}
