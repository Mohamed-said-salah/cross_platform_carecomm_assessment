import 'package:auto_route/auto_route.dart';
import 'package:cross_platform_product_listing_assessment/core/router/app_router.gr.dart';
import 'package:cross_platform_product_listing_assessment/data/models/product_model.dart';
import 'package:cross_platform_product_listing_assessment/views/components/buttons/product_favorite_button.dart';
import 'package:cross_platform_product_listing_assessment/views/components/product_image.dart';
import 'package:cross_platform_product_listing_assessment/views/components/spaces/horizontal_space.dart';
import 'package:cross_platform_product_listing_assessment/views/components/spaces/vertical_space.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/text_styles.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        context.router.push(ProductDetailsRoute(product: product));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImage(url: product.image ?? ""),
          HorizontalSpace(mobile: 10.w, tablet: 15.w, desktop: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(mobile: 10.h, tablet: 15.h, desktop: 20.h),
                Text(
                  product.title ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.headerMobile,
                ),
                VerticalSpace(mobile: 5.h, tablet: 10.h, desktop: 15.h),
                Text(
                  "EGP ${product.price ?? "0.00"}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.bodySmallMobile,
                ),
                VerticalSpace(mobile: 5.h, tablet: 10.h, desktop: 15.h),
                Text(
                  "${product.rating?.count ?? ""} Likes",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.bodyMediumMobile,
                ),
              ],
            ),
          ),
          ProductFavoriteButton(product: product),
        ],
      ),
    );
  }
}
