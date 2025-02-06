import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:cross_platform_product_listing_assessment/core/theme/text_styles.dart';
import 'package:cross_platform_product_listing_assessment/data/models/product_model.dart';
import 'package:cross_platform_product_listing_assessment/views/components/buttons/product_favorite_button.dart';
import 'package:cross_platform_product_listing_assessment/views/components/product_image.dart';
import 'package:cross_platform_product_listing_assessment/views/components/spaces/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(20.r),
      onTap: () {
        // todo: navigate to product details screen
      },
      child: Ink(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProductImage(url: product.image ?? ""),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.title ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: ResponsiveManager(context).responsiveValue(
                      TextStyles.headerMobile,
                      TextStyles.headerTablet,
                      TextStyles.headerDesktop,
                    ),
                  ),
                ),
                HorizontalSpace(),
                Text(
                  "EGP ${product.price ?? "0.00"}",
                  overflow: TextOverflow.ellipsis,
                  style: ResponsiveManager(context).responsiveValue(
                    TextStyles.bodyMediumMobile,
                    TextStyles.bodyMediumTablet,
                    TextStyles.bodyMediumDesktop,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Text(
                  "${product.rating?.count ?? ""} Likes",
                  overflow: TextOverflow.ellipsis,
                  style: ResponsiveManager(context).responsiveValue(
                    TextStyles.bodySmallMobile,
                    TextStyles.bodySmallTablet,
                    TextStyles.bodySmallDesktop,
                  ),
                ),
                Spacer(),
                ProductFavoriteButton(product: product),
              ],
            )
          ],
        ),
      ),
    );
  }
}
