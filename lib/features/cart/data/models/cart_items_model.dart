import '../../domain/entities/cart_items.dart';
import 'cart_product_item_model.dart';

class CartItemsModel extends CartItems {
  const CartItemsModel({
    required super.id,
    required super.quantity,
    required super.productItem,
  });

  factory CartItemsModel.fromJson(Map<String, dynamic> json) {
    return CartItemsModel(
      id: json['id'],
      quantity: json['quantity'],
      productItem: json['product'] != null
          ? CartProductItemModel.fromJson(json['product'])
          : null,
    );
  }
}
