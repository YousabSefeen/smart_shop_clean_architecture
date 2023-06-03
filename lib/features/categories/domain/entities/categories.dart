import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  const Categories({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, name, imageUrl];
}
