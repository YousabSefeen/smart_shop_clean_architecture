import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
    try {
      final result = await baseFavoritesRemoteDataSource.getFavorites();

      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error: error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, ChangeFavorite>> changeFavorite(
      ChangeFavoriteParameters parameters) async {
    try {
      final result =
          await baseFavoritesRemoteDataSource.changeFavorite(parameters);
      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error: error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
