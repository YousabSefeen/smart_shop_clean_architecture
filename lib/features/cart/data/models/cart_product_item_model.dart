import '../../domain/entities/cart_product_item.dart';

class CartProductItemModel extends CartProductItem {
  const CartProductItemModel({
    required super.id,
    required super.price,
    required super.oldPrice,
    required super.discount,
    required super.imageUrl,
    required super.name,
    required super.description,
    required super.inFavorite,
    required super.inCart,
  });

  factory CartProductItemModel.fromJson(Map<String, dynamic> json) {
    return CartProductItemModel(
      id: json['id'],
      price: json['price'].toDouble(),
      oldPrice: json['old_price'].toDouble(),
      discount: json['discount'],
      imageUrl: json['image'],
      name: json['name'],
      description: json['description'],
      inFavorite: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }
}
