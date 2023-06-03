import 'package:equatable/equatable.dart';

class SearchProducts extends Equatable {
  final int id;
  final double price;

  final String imageUrl;
  final String name;
  final String description;

  final bool isFavorite;
  final bool inCart;

  const SearchProducts({
    required this.id,
    required this.price,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.isFavorite,
    required this.inCart,
  });

  @override
  List<Object> get props => [
        id,
        price,
        imageUrl,
        name,
        description,
        isFavorite,
        inCart,
      ];
}
