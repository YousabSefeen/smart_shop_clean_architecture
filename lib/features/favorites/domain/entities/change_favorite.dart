import 'package:equatable/equatable.dart';

class ChangeFavorite extends Equatable {
  final String message;
  final FavoriteProduct favoriteProduct;

  const ChangeFavorite({required this.message, required this.favoriteProduct});

  @override
  List<Object> get props => [message, favoriteProduct];
}

class FavoriteProduct extends Equatable {
  final int id;
  final double price;
  final double oldPrice;

  final int discount;
  final String imageUrl;

  const FavoriteProduct({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, price, oldPrice, discount, imageUrl];
}
