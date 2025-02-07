import 'package:auto_route/auto_route.dart';
import 'package:cross_platform_product_listing_assessment/core/theme/responsive_manager.dart';
import 'package:cross_platform_product_listing_assessment/core/theme/text_styles.dart';
import 'package:cross_platform_product_listing_assessment/data/models/product_model.dart';
import 'package:cross_platform_product_listing_assessment/views/components/product_image.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text("${product.category?.toUpperCase()}",
            style: ResponsiveManager(context).responsiveValue(
              TextStyles.titleMobile,
              TextStyles.titleTablet,
              TextStyles.titleDesktop,
            )),
      ),
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
        Expanded(
          flex: 1,
          child: ProductImage(url: product.image ?? ""),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title ?? 'No Title',
                style: ResponsiveManager(context).responsiveValue(
                  TextStyles.headerMobile,
                  TextStyles.headerTablet,
                  TextStyles.headerDesktop,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(height: 8),
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

  Column buildMobileAndTablet(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.network(
            product.image ?? '',
            height: 200,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.image_not_supported, size: 100, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          product.title ?? 'No Title',
          style: ResponsiveManager(context).responsiveValue(
              TextStyles.headerMobile,
              TextStyles.headerTablet,
              TextStyles.headerDesktop),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(height: 8),
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
        Text(
          product.description ?? 'No description available.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
