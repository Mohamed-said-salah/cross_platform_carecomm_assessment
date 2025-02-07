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

    getIt<FavoritesCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      bloc: getIt<FavoritesCubit>(),
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FavoritesLoaded) {
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

        return const Center(child: Text("Nothing to show"));
      },
    );
  }

  ListView _mobileListView(FavoritesLoaded state) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        return ProductTile(product: state.products[index]);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

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

  GridView _desktopView(FavoritesLoaded state) {
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
