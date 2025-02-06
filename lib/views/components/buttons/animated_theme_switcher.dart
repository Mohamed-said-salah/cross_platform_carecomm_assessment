import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../logic/cubit/theme_cubit.dart';

class AnimatedThemeSwitcher extends StatelessWidget {
  const AnimatedThemeSwitcher({super.key});
  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final isDarkMode = themeMode == ThemeMode.dark;

    return GestureDetector(
      onTap: () => context.read<ThemeCubit>().toggleTheme(),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300), // Smooth transition duration
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          isDarkMode ? Icons.light_mode : Icons.dark_mode,
          key: ValueKey<bool>(
              isDarkMode), // Key helps AnimatedSwitcher know the state change
          size: ResponsiveManager(context).responsiveValue(30.w, 35.w, 40.w),
          color: isDarkMode
              ? Colors.amber
              : const Color.fromARGB(255, 81, 105, 117),
        ),
      ),
    );
  }
}
