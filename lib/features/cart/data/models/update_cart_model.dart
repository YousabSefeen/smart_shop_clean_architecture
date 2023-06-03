import '../../domain/entities/update_cart.dart';

class UpdateCartModel extends UpdateCart {
  const UpdateCartModel({required super.quantity});

  factory UpdateCartModel.fromJson(Map<String, dynamic> json) {
    return UpdateCartModel(quantity: json['quantity']);
  }
}
