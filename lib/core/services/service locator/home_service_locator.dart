import '../../../features/home data/data/data source/home_remote_data_source.dart';
import '../../../features/home data/data/repository/home_repository.dart';
import '../../../features/home data/domain/base home repository/base_home_repository.dart';
import '../../../features/home data/domain/use cases/get_banners_use_case.dart';
import '../../../features/home data/domain/use cases/get_products_use_cases.dart';
import '../../../features/home data/presentation/controller/cubit/home_cubit.dart';
import '../../utils/global_constants.dart';
import '../../utils/theme and language/controller/theme_and_language_cubit.dart';

class HomeServiceLocator {
  void init() {
    /// RemoteDataSource/BaseHomeRepository/Use Case/ Bloc

    // Todo RemoteDataSource
    sl.registerLazySingleton<BaseHomeRemoteDataSource>(
        () => HomeRemoteDataSource());

    //Todo BaseHomeRepository

    sl.registerLazySingleton<BaseHomeRepository>(
        () => HomeRepository(baseHomeRemoteDataSource: sl()));
    //Todo Use Case

    sl.registerLazySingleton(() => GetBannersUseCase(baseHomeRepository: sl()));

    sl.registerLazySingleton(
        () => GetProductsUseCase(baseHomeRepository: sl()));

    //Todo Bloc

    sl.registerFactory(() => HomeCubit(
          getBannersUseCase: sl(),
          getProductsUseCase: sl(),
        ));
    sl.registerFactory(() => ThemeAndLanguageCubit());
  }
}
