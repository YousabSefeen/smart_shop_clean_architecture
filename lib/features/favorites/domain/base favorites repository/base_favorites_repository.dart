import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/change_favorite.dart';
import '../entities/favorites.dart';
import '../use cases/change_favorite_use_case.dart';

abstract class BaseFavoritesRepository {
  Future<Either<Failure, List<Favorites>>> getFavorites();

  Future<Either<Failure, ChangeFavorite>> changeFavorite(
      ChangeFavoriteParameters parameters);
}
