import '../../domain/entities/change_favorite.dart';

class ChangeFavoriteModel extends ChangeFavorite {
  const ChangeFavoriteModel(
      {required super.message, required super.favoriteProduct});

  factory ChangeFavoriteModel.fromJson(Map<String, dynamic> json) {
    return ChangeFavoriteModel(
      message: json['message'],
      favoriteProduct: FavoriteProductModel.fromJson(json['data']['product']),
    );
  }
}

class FavoriteProductModel extends FavoriteProduct {
  const FavoriteProductModel(
      {required super.id,
      required super.price,
      required super.oldPrice,
      required super.discount,
      required super.imageUrl});

  factory FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProductModel(
      id: json['id'],
      price: json['price'].toDouble(),
      oldPrice: json['old_price'].toDouble(),
      discount: json['discount'],
      imageUrl: json['image'],
    );
  }
}
