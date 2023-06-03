import 'package:equatable/equatable.dart';

class CartProductItem extends Equatable {
  final int id;
  final double price;
  final double oldPrice;
  final int discount;
  final String imageUrl;
  final String name;
  final String description;
  final bool inFavorite;
  final bool inCart;

  const CartProductItem({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.inFavorite,
    required this.inCart,
  });

  @override
  List<Object> get props => [
        id,
        price,
        oldPrice,
        discount,
        imageUrl,
        name,
        description,
        inFavorite,
        inCart,
      ];
}
