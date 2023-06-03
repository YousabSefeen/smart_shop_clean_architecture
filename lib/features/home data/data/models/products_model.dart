import '../../domain/entities/products.dart';

class ProductsModel extends Products {
  const ProductsModel({
    required super.id,
    required super.price,
    required super.oldPrice,
    required super.discount,
    required super.imageUrl,
    required super.name,
    required super.description,
    required super.imagesUrl,
    required super.inFavorite,
    required super.inCart,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      price: json['price'].toDouble(),
      oldPrice: json['old_price'].toDouble(),
      discount: json['discount'],
      imageUrl: json['image'],
      name: json['name'],
      description: json['description'],
      imagesUrl: json['images'],
      inFavorite: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }
}
