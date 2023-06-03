import '../../domain/entities/category_details.dart';

class CategoryDetailsModel extends CategoryDetails {
  const CategoryDetailsModel({
    required super.id,
    required super.price,
    required super.oldPrice,
    required super.discount,
    required super.imageUrl,
    required super.name,
    required super.description,
  });

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    return CategoryDetailsModel(
      id: json['id'],
      price: json['price'].toDouble(),
      oldPrice: json['old_price'].toDouble(),
      discount: json['discount'],
      imageUrl: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
