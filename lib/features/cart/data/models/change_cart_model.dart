import '../../domain/entities/change_cart.dart';

class ChangeCartModel extends ChangeCart {
  const ChangeCartModel({
    required super.status,
    required super.message,
    required super.changeCartProduct,
  });

  factory ChangeCartModel.fromJson(Map<String, dynamic> json) {
    return ChangeCartModel(
      status: json['status'],
      message: json['message'],
      changeCartProduct:
          ChangeCartProductModel.fromJson(json['data']['product']),
    );
  }
}

class ChangeCartProductModel extends ChangeCartProduct {
  const ChangeCartProductModel({
    required super.id,
    required super.price,
    required super.oldPrice,
    required super.discount,
    required super.imageUrl,
  });

  factory ChangeCartProductModel.fromJson(Map<String, dynamic> json) {
    return ChangeCartProductModel(
      id: json['id'],
      price: json['price'].toDouble(),
      oldPrice: json['old_price'].toDouble(),
      discount: json['discount'],
      imageUrl: json['image'],
    );
  }
}
