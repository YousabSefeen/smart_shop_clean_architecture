import '../../domain/entities/cart.dart';
import 'cart_items_model.dart';

class CartModel extends Cart {
  const CartModel({
    required super.subTotal,
    required super.total,
    required super.cartItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      subTotal: json['sub_total'].toDouble(),
      total: json['total'].toDouble(),
      cartItems: json['cart_items'] != null
          ? List<CartItemsModel>.from(json['cart_items'].map(
              (e) => CartItemsModel.fromJson(e),
            ))
          : null,
    );
  }
}
