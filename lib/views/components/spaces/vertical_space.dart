import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalSpace extends StatelessWidget {
  final double? mobile;
  final double? tablet;
  final double? desktop;

  /// Constructs a [VerticalSpace] widget with optional [mobile], [tablet], and [desktop] values.
  ///
  /// The [mobile], [tablet], and [desktop] values are used to set the height of the space for different screen sizes.
  ///
  /// If none of the values are provided, the space is set to 10.w for mobile, 15.w for tablet, and 20.w for desktop.
  ///
  /// Returns a [SizedBox] widget with the specified height.
  ///
  const VerticalSpace({super.key, this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: ResponsiveManager(context).responsiveValue(
      mobile ?? 10.w,
      15.w,
      20.w,
    ));
  }
}
