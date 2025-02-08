import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalSpace extends StatelessWidget {
  final double? mobile;
  final double? tablet;
  final double? desktop;

  /// Constructs a [HorizontalSpace] widget with optional sizes for mobile, tablet, and desktop.
  ///
  /// The [mobile], [tablet], and [desktop] parameters are optional and default to null.
  ///
  /// Returns a [SizedBox] widget with the specified width.
  ///
  const HorizontalSpace({super.key, this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ResponsiveManager(context).responsiveValue(
      mobile ?? 10.w,
      15.w,
      20.w,
    ));
  }
}
