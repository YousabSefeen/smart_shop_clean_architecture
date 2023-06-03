import 'package:equatable/equatable.dart';

class ChangeCart extends Equatable {
  final bool status;
  final String message;
  final ChangeCartProduct changeCartProduct;

  const ChangeCart({
    required this.status,
    required this.message,
    required this.changeCartProduct,
  });

  @override
  List<Object> get props => [status, message, changeCartProduct];
}

class ChangeCartProduct extends Equatable {
  final int id;
  final double price;
  final double oldPrice;
  final int discount;
  final String imageUrl;

  const ChangeCartProduct({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, price, oldPrice, discount, imageUrl];
}
