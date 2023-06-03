import 'package:equatable/equatable.dart';

class Banners extends Equatable {
  final int id;
  final String imageUrl;

  const Banners({
    required this.id,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, imageUrl];
}
