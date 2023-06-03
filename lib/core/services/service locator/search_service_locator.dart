import '../../../features/search/data/data source/search_products_remote_data_source.dart';
import '../../../features/search/data/repository/search_products_repository.dart';
import '../../../features/search/domain/base search repository/base_search_products_repository.dart';
import '../../../features/search/domain/use cases/search_product_use_case.dart';
import '../../../features/search/presentation/controller/cubit/search_products_cubit.dart';
import '../../utils/global_constants.dart';

class SearchServiceLocator {
  void init() {
    /// RemoteDataSource/BaseHomeRepository/Use Case/ Bloc

    // Todo RemoteDataSource

    sl.registerLazySingleton<BaseSearchProductsRemoteDataSource>(
        () => SearchProductsRemoteDataSource());
//Todo BaseHomeRepository
    sl.registerLazySingleton<BaseSearchProductsRepository>(() =>
        SearchProductsRepository(baseSearchProductsRemoteDataSource: sl()));
    //Todo Use Case
    sl.registerLazySingleton(
        () => SearchProductsUseCase(baseSearchProductsRepository: sl()));
    //Todo Bloc
    sl.registerFactory(() => SearchProductsCubit(
          searchProductsUseCase: sl(),
        ));
  }
}
