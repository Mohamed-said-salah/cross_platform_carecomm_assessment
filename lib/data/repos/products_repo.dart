import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:cross_platform_product_listing_assessment/core/constants.dart';

import '../models/product_model.dart';

class ProductsRepo {
  final http.Client client;

  ProductsRepo(this.client);

  /// Fetches a list of products from the server.
  ///
  /// Sends a GET request to the products endpoint defined in [Constants.baseUrl].
  /// If the request is successful (HTTP status 200 or 201), it decodes the JSON
  /// response and maps it to a list of [ProductModel] objects.
  ///
  /// Returns a `Future` containing a list of [ProductModel] objects on success,
  /// or `null` if the request fails or an exception occurs.
  Future<List<ProductModel>?> getProducts() async {
    final Uri url = Uri.parse('${Constants.baseUrl}/products');

    try {
      final result = await client.get(url);

      if (result.statusCode == 200 || result.statusCode == 201) {
        final List<dynamic> decodedBody = jsonDecode(result.body);
        final List<ProductModel> products =
            decodedBody.map((item) => ProductModel.fromJson(item)).toList();
        return products;
      }
    } catch (e) {
      print(e);
    }

    return null;
  }
}
