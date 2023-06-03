import 'package:equatable/equatable.dart';

import 'cart_product_item.dart';

class CartItems extends Equatable {
  final int id;
  final int quantity;
  final CartProductItem? productItem;

  const CartItems({
    required this.id,
    required this.quantity,
    required this.productItem,
  });

  @override
  List<Object?> get props => [id, quantity, productItem];
}
