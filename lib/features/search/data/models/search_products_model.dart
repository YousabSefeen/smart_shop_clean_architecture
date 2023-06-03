import '../../domain/entities/search_products.dart';

class SearchProductsModel extends SearchProducts {
  const SearchProductsModel(
      {required super.id,
      required super.price,
      required super.imageUrl,
      required super.name,
      required super.description,
      required super.isFavorite,
      required super.inCart});

  factory SearchProductsModel.fromJson(Map<String, dynamic> json) {
    return SearchProductsModel(
      id: json['id'],
      price: json['price'].toDouble(),
      imageUrl: json['image'],
      name: json['name'],
      description: json['description'],
      isFavorite: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }
}
