import '../../../features/favorites/data/data source/favorites_remote_data_source.dart';
import '../../../features/favorites/data/repository/favorites_repository.dart';
import '../../../features/favorites/domain/base favorites repository/base_favorites_repository.dart';
import '../../../features/favorites/domain/use cases/change_favorite_use_case.dart';
import '../../../features/favorites/domain/use cases/get_favorites_use_case.dart';
import '../../../features/favorites/presentation/controller/cubit/favorites_cubit.dart';
import '../../utils/global_constants.dart';

class FavoriteServiceLocator {
  void init() {
    /// RemoteDataSource/BaseHomeRepository/Use Case/ Bloc

    // Todo RemoteDataSource

    sl.registerLazySingleton<BaseFavoritesRemoteDataSource>(
        () => FavoritesRemoteDataSource());

    //Todo BaseHomeRepository

    sl.registerLazySingleton<BaseFavoritesRepository>(
        () => FavoritesRepository(baseFavoritesRemoteDataSource: sl()));

    //Todo Use Case

    ///favorites
    sl.registerLazySingleton(
        () => GetFavoritesUseCase(baseFavoritesRepository: sl()));
    sl.registerLazySingleton(
        () => ChangeFavoriteUseCase(baseFavoritesRepository: sl()));

    //Todo Bloc

    sl.registerFactory(() => FavoritesCubit(
          getFavoritesUseCase: sl(),
          changeFavoriteUseCase: sl(),
        ));
  }
}
