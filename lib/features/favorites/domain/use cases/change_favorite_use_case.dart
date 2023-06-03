import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base favorites repository/base_favorites_repository.dart';
import '../entities/change_favorite.dart';

class ChangeFavoriteUseCase
    extends BaseUseCase<ChangeFavorite, ChangeFavoriteParameters> {
  final BaseFavoritesRepository baseFavoritesRepository;

  ChangeFavoriteUseCase({required this.baseFavoritesRepository});

  @override
  Future<Either<Failure, ChangeFavorite>> call(
      ChangeFavoriteParameters parameters) async {
    return await baseFavoritesRepository.changeFavorite(parameters);
  }
}

class ChangeFavoriteParameters extends Equatable {
  final int id;

  const ChangeFavoriteParameters({required this.id});

  @override
  List<Object> get props => [id];
}
