import 'package:auto_route/auto_route.dart';
import 'package:cross_platform_product_listing_assessment/core/di.dart';
import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:cross_platform_product_listing_assessment/core/theme/text_styles.dart';
import 'package:cross_platform_product_listing_assessment/logic/cubit/products_cubit.dart';
import 'package:cross_platform_product_listing_assessment/views/components/cards/product_card.dart';
import 'package:cross_platform_product_listing_assessment/views/components/tiles/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/buttons/animated_theme_switcher.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    getIt<ProductsCubit>().emitProductsState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CareComm Task",
          style: ResponsiveManager(context).responsiveValue(
            TextStyles.titleMobile,
            TextStyles.titleTablet,
            TextStyles.titleDesktop,
          ),
        ),
        toolbarHeight:
            ResponsiveManager(context).responsiveValue(80.w, 100.w, 100.w),
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: AnimatedThemeSwitcher(),
          ),
        ],
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        bloc: getIt<ProductsCubit>(),
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductsSuccess) {
            return LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth < 800) {
                return mobileListView(state);
              } else if (constraints.maxWidth < 1200) {
                return tabletView(state);
              } else {
                return desktopView(state);
              }
            });
          }

          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }

  ListView mobileListView(ProductsSuccess state) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        return ProductTile(product: state.products[index]);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  GridView tabletView(ProductsSuccess state) {
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

  GridView desktopView(ProductsSuccess state) {
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
