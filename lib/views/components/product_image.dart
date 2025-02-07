import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
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
