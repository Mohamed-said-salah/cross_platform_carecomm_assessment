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
  Widget build(BuildContext context) {
    // <--- Build a default [TabBarView] for the products and favorites tabs.
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // <--- Display sliver app bar and body.
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // <--- Display the app bar.
            SliverAppBar(
              // <--- Display the app bar title.
              title: Text(
                "CareComm Task",
                style: ResponsiveManager(context).responsiveValue(
                  TextStyles.titleMobile,
                  TextStyles.titleTablet,
                  TextStyles.titleDesktop,
                ),
              ),
              floating: true, // Makes the app bar hide/show on scroll
              snap: true, // Makes the app bar snap into view when scrolling up
              toolbarHeight: ResponsiveManager(context)
                  .responsiveValue(80.w, 100.w, 100.w),
              scrolledUnderElevation: 0,
              elevation: 0,
              actions: [
                // <--- Display the theme switcher. --->
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: AnimatedThemeSwitcher(),
                ),
              ],
              // <--- Display the tab bar. --->
              bottom: TabBar(
                // <--- Display the tabs.
                tabs: const [
                  Tab(text: "Products"),
                  Tab(text: "Favorites"),
                ],
                // <--- Set the indicator color, label color, label style, padding, unselected label color, indicator size, indicator padding, and indicator weight.
                indicatorColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.grey,
                labelColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                labelStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
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
          ],
          // <--- Display the tab bar view. --->
          body: TabBarView(
            children: [
              // <--- Display the products fetched from api --->
              ProductsTab(),
              // <--- Display the favorites from local storage --->
              FavoritesTab(),
            ],
          ),
        ),
      ),
    );
  }
}
