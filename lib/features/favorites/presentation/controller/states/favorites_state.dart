import 'package:equatable/equatable.dart';

import '../../../../../core/utils/enums/request_state.dart';
import '../../../domain/entities/change_favorite.dart';
import '../../../domain/entities/favorites.dart';

class FavoritesState extends Equatable {
  final List<Favorites> favorites;

  final RequestState favoritesState;

  final String favoritesErrorMessage;

  // ******
  final ChangeFavorite? changeFavorite;
  final RequestState changeFavoriteState;

  final String changeFavoriteErrorMessage;

  // ****

  const FavoritesState({
    this.favorites = const [],
    this.favoritesState = RequestState.loading,
    this.favoritesErrorMessage = '',
    this.changeFavorite,
    this.changeFavoriteState = RequestState.loading,
    this.changeFavoriteErrorMessage = '',
  });

  FavoritesState copyWith({
    List<Favorites>? favorites,
    RequestState? favoritesState,
    String? favoritesErrorMessage,
    ChangeFavorite? changeFavorite,
    RequestState? changeFavoriteState,
    String? changeFavoriteErrorMessage,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      favoritesState: favoritesState ?? this.favoritesState,
      favoritesErrorMessage:
          favoritesErrorMessage ?? this.favoritesErrorMessage,
      //*****
      changeFavorite: changeFavorite ?? this.changeFavorite,
      changeFavoriteState: changeFavoriteState ?? this.changeFavoriteState,
      changeFavoriteErrorMessage:
          changeFavoriteErrorMessage ?? this.changeFavoriteErrorMessage,

      //***
    );
  }

  @override
  List<Object?> get props => [
        favorites,
        favoritesState,
        favoritesErrorMessage,
        changeFavorite,
        changeFavoriteState,
        changeFavoriteErrorMessage,
      ];
}
