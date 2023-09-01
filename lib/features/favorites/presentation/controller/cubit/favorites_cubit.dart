import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/base  use case/base_use_case.dart';
import '../../../../../core/common presentation/widgets/custom_app_alerts.dart';
import '../../../../../core/utils/enums/request_state.dart';
import '../../../../../core/utils/global_constants.dart';
import '../../../domain/use cases/change_favorite_use_case.dart';
import '../../../domain/use cases/get_favorites_use_case.dart';
import '../../../presentation/controller/states/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  GetFavoritesUseCase getFavoritesUseCase;
  ChangeFavoriteUseCase changeFavoriteUseCase;

  FavoritesCubit({
    required this.getFavoritesUseCase,
    required this.changeFavoriteUseCase,
  }) : super(const FavoritesState());

  static FavoritesCubit object(context) => BlocProvider.of(context);

  FutureOr<void> getFavorites() async {
    final result = await getFavoritesUseCase(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
              favoritesState: RequestState.error,
              favoritesErrorMessage: l.errorMessage,
            )),
        (r) => emit(state.copyWith(
              favorites: r,
              favoritesState: RequestState.loaded,
            )));
  }

  FutureOr<void> changeFavorite(
      {required int id, required BuildContext context}) async {
    favorites[id] = !favorites[id]!;
    final result =
        await changeFavoriteUseCase(ChangeFavoriteParameters(id: id));

    result.fold(
      (l) {
        favorites[id] = !favorites[id]!;
        emit(state.copyWith(
          changeFavoriteState: RequestState.error,
          changeFavoriteErrorMessage: l.errorMessage,
        ));
        CustomAppAlerts.customSnackBar(
          context: context,
          message: state.changeFavorite!.message,
        );
      },
      (r) {
        emit(state.copyWith(
          changeFavorite: r,
          changeFavoriteState: RequestState.loaded,
        ));
        CustomAppAlerts.customSnackBar(
          context: context,
          message: state.changeFavorite!.message,
        );
      },
    );

    getFavorites();
  }
}
