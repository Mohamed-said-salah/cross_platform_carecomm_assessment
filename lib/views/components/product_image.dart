import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;

  /// A widget that displays an image of a product
  ///
  /// [url] - The URL of the image
  /// [width] - The width of the image
  /// [height] - The height of the image
  ///
  const ProductImage({super.key, required this.url, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ??
          ResponsiveManager(context).responsiveValue(90.w, 320.w, 380.w),
      height: height ??
          ResponsiveManager(context).responsiveValue(90.w, 200.w, 240.w),
      child: FastCachedImage(
        url: url,

        // <--- Set the placeholder and error widgets for the image --->
        loadingBuilder: (p0, p1) => Container(
          width: width ??
              ResponsiveManager(context).responsiveValue(90.w, 320.w, 380.w),
          height: height ??
              ResponsiveManager(context).responsiveValue(90.w, 200.w, 240.w),
        ),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
