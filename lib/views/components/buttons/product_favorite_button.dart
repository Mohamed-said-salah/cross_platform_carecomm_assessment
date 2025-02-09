import 'package:cross_platform_product_listing_assessment/core/di.dart';
import 'package:cross_platform_product_listing_assessment/core/services/favorites_caching_service.dart';
import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:cross_platform_product_listing_assessment/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductFavoriteButton extends StatefulWidget {
  /// Creates a [ProductFavoriteButton] widget.
  ///
  /// The [product] argument must not be null.
  ///
  /// Returns a [ProductFavoriteButton] widget.
  ///
  const ProductFavoriteButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductFavoriteButton> createState() => _ProductFavoriteButtonState();
}

class _ProductFavoriteButtonState extends State<ProductFavoriteButton> {
  bool isFavorite = false;

  /// Calls [_loadFavoriteStatus] after the widget is inserted into the tree.
  ///
  /// This is done to load the favorite status of the product from the cache as
  /// soon as the widget is inserted into the tree, so that the button displays
  /// the correct state.
  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  /// Loads the favorite status of the product from the cache and updates the
  /// state with the result.
  ///
  /// This method is called in [initState] to load the favorite status of the
  /// product as soon as the widget is inserted into the tree, so that the button
  /// displays the correct state.
  void _loadFavoriteStatus() async {
    isFavorite = await FavoritesCachingService(getIt())
        .isFavoriteProduct(widget.product);
    if (mounted) setState(() {});
  }

  /// Toggles the favorite status of the product.
  ///
  /// If the product is currently not a favorite, adds it to the list of
  /// favorites. If the product is currently a favorite, removes it from the
  /// list of favorites.
  ///
  /// This method is called when the button is pressed.
  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    // <--- If the product is currently not a favorite, add it to the list of favorites.
    // <--- If the product is currently a favorite, remove it from the list of favorites.
    if (isFavorite) {
      FavoritesCachingService(getIt()).addFavoriteProduct(widget.product);
    } else {
      FavoritesCachingService(getIt()).removeFavoriteProduct(widget.product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavorite,
      icon: AnimatedSwitcher(
        // <--- Define the animation duration and transition builder.
        duration: const Duration(milliseconds: 220),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),

        // <--- Display the favorite icon with the correct color.
        child: TweenAnimationBuilder<Color?>(
          key: ValueKey<bool>(isFavorite),

          // <--- Define the animation duration and color tween.
          tween: ColorTween(
              begin: Colors.grey, end: isFavorite ? Colors.red : Colors.grey),
          duration: const Duration(milliseconds: 300),

          // <--- Display the favorite icon with the correct color.
          builder: (context, color, child) => Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: ResponsiveManager(context).responsiveValue(31.w, 32.w, 32.w),
            color: color,
          ),
        ),
      ),
    );
  }
}
