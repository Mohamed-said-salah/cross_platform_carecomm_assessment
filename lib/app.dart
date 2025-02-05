import 'package:cross_platform_product_listing_assessment/core/router/app_router.dart';
import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:cross_platform_product_listing_assessment/logic/cubit/theme_cubit.dart';
import 'package:cross_platform_product_listing_assessment/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  App({
    super.key,
  });

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return ScreenUtilInit(
          designSize: ResponsiveManager(context).responsiveValue(
            Size(1344, 2992),
            Size(1344, 2992),
            Size(1344, 2992),
          ),
          minTextAdapt: true,
          splitScreenMode: false,
          builder: (_, child) {
            return MaterialApp.router(
              routerConfig: _appRouter.config(),
              title: "CareComm Task",
              debugShowCheckedModeBanner: false,
              themeMode: mode,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
            );
          },
          child: HomeScreen(),
        );
      },
    );
  }
}
