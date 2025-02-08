import 'package:auto_route/auto_route.dart';
import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:cross_platform_product_listing_assessment/core/theme/text_styles.dart';
import 'package:cross_platform_product_listing_assessment/data/models/product_model.dart';
import 'package:cross_platform_product_listing_assessment/views/components/product_image.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductDetailsScreen extends StatelessWidget {
  // <--- Receive the product as a parameter --->
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // <--- Display the back button --->
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        // <--- Display the product category --->
        title: Text("${product.category?.toUpperCase()}",
            style: ResponsiveManager(context).responsiveValue(
              TextStyles.titleMobile,
              TextStyles.titleTablet,
              TextStyles.titleDesktop,
            )),
      ),
      // <--- Display the product details --->
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ResponsiveManager(context).responsiveValue(
          buildMobileAndTablet(context),
          buildMobileAndTablet(context),
          buildDesktop(context),
        ),
      ),
    );
  }

  Row buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // <--- Display the product image --->
        Expanded(
          flex: 1,
          child: ProductImage(url: product.image ?? ""),
        ),
        const SizedBox(width: 32),
        // <--- Display the product details --->
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // <--- Display the product title --->
              Text(
                product.title ?? 'No Title',
                style: ResponsiveManager(context).responsiveValue(
                  TextStyles.headerMobile,
                  TextStyles.headerTablet,
                  TextStyles.headerDesktop,
                ),
              ),
              const SizedBox(height: 8),
              // <--- Display the product price --->
              Text(
                '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(height: 8),
              // <--- Display the product rating --->
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Text(
                    '${product.rating?.rate ?? 'N/A'} (${product.rating?.count ?? 0} reviews)',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // <--- Display the product description --->
              Text(
                product.description ?? 'No description available.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the UI for mobile and tablet screen sizes.
  ///
  /// This function is used by [ResponsiveManager] to build the UI for mobile and tablet
  /// screen sizes. It returns a [Column] widget with the product image, title, price,
  /// rating, and description.
  ///
  /// The product image is displayed centered at the top of the column. The title is
  /// displayed below the image with a large font size. The price is displayed below the
  /// title with a green color and a bold font. The rating is displayed below the price
  /// with a yellow color and a smaller font size. The description is displayed below the
  /// rating with a normal font size.
  Column buildMobileAndTablet(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // <--- Display the product image --->
        Center(
          child: Image.network(
            product.image ?? '',
            height: 200,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 16),
        // <--- Display the product title --->
        Text(
          product.title ?? 'No Title',
          style: ResponsiveManager(context).responsiveValue(
              TextStyles.headerMobile,
              TextStyles.headerTablet,
              TextStyles.headerDesktop),
        ),
        const SizedBox(height: 8),
        // <--- Display the product price --->
        Text(
          '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: 8),
        // <--- Display the product rating --->
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber),
            Text(
              '${product.rating?.rate ?? 'N/A'} (${product.rating?.count ?? 0} reviews)',
              style: ResponsiveManager(context).responsiveValue(
                  TextStyles.bodySmallMobile,
                  TextStyles.bodySmallTablet,
                  TextStyles.bodySmallDesktop),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // <--- Display the product description --->
        Text(
          product.description ?? 'No description available.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
