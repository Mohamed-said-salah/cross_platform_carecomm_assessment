import 'package:auto_route/auto_route.dart';
import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:cross_platform_product_listing_assessment/core/theme/text_styles.dart';
import 'package:cross_platform_product_listing_assessment/views/screens/home/favorites_tab.dart';
import 'package:cross_platform_product_listing_assessment/views/screens/home/products_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/buttons/animated_theme_switcher.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "CareComm Task",
            style: ResponsiveManager(context).responsiveValue(
              TextStyles.titleMobile,
              TextStyles.titleTablet,
              TextStyles.titleDesktop,
            ),
          ),
          leading: SizedBox(),
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

          // <--- Tab bar ---->
          bottom: TabBar(
            tabs: const [
              Tab(text: "Products"),
              Tab(text: "Favorites"),
            ],
            indicatorColor: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.grey,
            labelColor: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            labelStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            padding: EdgeInsets.only(bottom: 10.h),
            unselectedLabelColor:
                Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 15.w),
            indicatorWeight: 5.h,
            dividerColor: Colors.transparent,
          ),
        ),
        body: TabBarView(
          children: [
            ProductsTab(),
            FavoritesTab(),
          ],
        ),
      ),
    );
  }
}
