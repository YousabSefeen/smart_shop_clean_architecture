import '../../../features/categories/data/data source/categories_remote_data_source.dart';
import '../../../features/categories/data/repository/categories_repository.dart';
import '../../../features/categories/domain/base repository/base_categories_ repository.dart';
import '../../../features/categories/domain/use cases/get_categories_use_case.dart';
import '../../../features/categories/domain/use cases/get_category_details_use_case.dart';
import '../../../features/categories/presentation/controller/cubit/categories_cubit.dart';
import '../../utils/global_constants.dart';

class CategoriesServiceLocator {
  void init() {
    /// RemoteDataSource/BaseHomeRepository/Use Case/ Bloc

    // Todo RemoteDataSource
    sl.registerLazySingleton<BaseCategoriesRemoteDataSource>(
        () => CategoriesRemoteDataSource());

    //Todo BaseHomeRepository

    sl.registerLazySingleton<BaseCategoriesRepository>(
        () => CategoriesRepository(
              baseCategoriesRemoteDataSource: sl(),
            ));
    //Todo Use Case

    sl.registerLazySingleton(
      () => GetCategoriesUseCase(baseCategoriesRepository: sl()),
    );
    sl.registerLazySingleton(
      () => GetCategoryDetailsUseCase(baseCategoriesRepository: sl()),
    );
    //Todo Bloc

    sl.registerFactory(() => CategoriesCubit(
          getCategoriesUseCase: sl(),
          getCategoryDetailsUseCase: sl(),
        ));
  }
}
