import '../../domain/entities/banners.dart';

class BannersModel extends Banners {
  const BannersModel({
    required super.id,
    required super.imageUrl,
  });

  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      id: json['id'],
      imageUrl: json['image'],
    );
  }
}
