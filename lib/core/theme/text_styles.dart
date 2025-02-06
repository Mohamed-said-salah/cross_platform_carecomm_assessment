import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyles {
  static final titleMobile =
      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w800);
  static final titleTablet =
      TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w900);
  static final titleDesktop =
      TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w900);

  static final headerMobile =
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold);
  static final headerTablet =
      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w800);
  static final headerDesktop =
      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w800);

  static final bodyMediumMobile =
      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600);
  static final bodyMediumTablet =
      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold);
  static final bodyMediumDesktop =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold);

  static final bodySmallMobile =
      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500);
  static final bodySmallTablet =
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600);
  static final bodySmallDesktop =
      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600);
}
