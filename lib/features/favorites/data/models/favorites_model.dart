import '../../domain/entities/favorites.dart';

class FavoritesModel extends Favorites {
  const FavoritesModel({
    required super.id,
    required super.productItemFavorite,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
      id: json['id'],
      productItemFavorite: json['product'] != null
          ? ProductItemFavoriteModel.fromJson(json['product'])
          : null,
    );
  }
}

class ProductItemFavoriteModel extends ProductItemFavorite {
  const ProductItemFavoriteModel(
      {required super.id,
      required super.price,
      required super.oldPrice,
      required super.discount,
      required super.imageUrl,
      required super.name,
      required super.description});

  factory ProductItemFavoriteModel.fromJson(Map<String, dynamic> json) {
    return ProductItemFavoriteModel(
      id: json['id'],
      price: json['price'].toDouble(),
      oldPrice: json['old_price'].toDouble(),
      discount: json['discount'],
      imageUrl: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
