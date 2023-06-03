import 'package:dartz/dartz.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base favorites repository/base_favorites_repository.dart';
import '../entities/favorites.dart';

class GetFavoritesUseCase extends BaseUseCase<List<Favorites>, NoParameters> {
  BaseFavoritesRepository baseFavoritesRepository;

  GetFavoritesUseCase({required this.baseFavoritesRepository});

  @override
  Future<Either<Failure, List<Favorites>>> call(NoParameters parameters) async {
    return await baseFavoritesRepository.getFavorites();
  }
}
