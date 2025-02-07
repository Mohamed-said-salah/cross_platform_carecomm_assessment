import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;

  String? title;
  num? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductModel({
    required this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
    );
  }

  /// Converts this object to a JSON encodable map.
  ///
  /// Returns a `Map<String, dynamic>` containing the object's properties.
  ///
  /// The returned map is suitable for encoding to JSON with `jsonEncode()`.
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating?.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
      ];
}

class Rating extends Equatable {
  num? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'],
      count: json['count'],
    );
  }

  /// Converts this object to a JSON encodable map.
  ///
  /// Returns a `Map<String, dynamic>` containing the object's properties.
  ///
  /// The returned map is suitable for encoding to JSON with `jsonEncode()`.
  Map<String, dynamic> toJson() => {
        'rate': rate,
        'count': count,
      };

  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
