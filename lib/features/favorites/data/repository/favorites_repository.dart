import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/base favorites repository/base_favorites_repository.dart';
import '../../domain/entities/change_favorite.dart';
import '../../domain/entities/favorites.dart';
import '../../domain/use cases/change_favorite_use_case.dart';
import '../data source/favorites_remote_data_source.dart';

class FavoritesRepository extends BaseFavoritesRepository {
  final BaseFavoritesRemoteDataSource baseFavoritesRemoteDataSource;

  FavoritesRepository({required this.baseFavoritesRemoteDataSource});

  @override
  Future<Either<Failure, List<Favorites>>> getFavorites() async {
    final result = await baseFavoritesRemoteDataSource.getFavorites();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, ChangeFavorite>> changeFavorite(
      ChangeFavoriteParameters parameters) async {
    final result =
        await baseFavoritesRemoteDataSource.changeFavorite(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.message));
    }
  }
}
