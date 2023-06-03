import '../../../features/cart/data/data source/cart_remote_data_source.dart';
import '../../../features/cart/data/repository/cart_repository.dart';
import '../../../features/cart/domain/base cart repository/base_cart_repository.dart';
import '../../../features/cart/domain/use cases/change_cart_use_case.dart';
import '../../../features/cart/domain/use cases/get_cart_use_case.dart';
import '../../../features/cart/domain/use cases/update_cart_use_case.dart';
import '../../../features/cart/presentation/controller/cubit/cart_cubit.dart';
import '../../utils/global_constants.dart';

class CartServiceLocator {
  void init() {
    /// RemoteDataSource/BaseHomeRepository/Use Case/ Bloc

    // Todo RemoteDataSource

    sl.registerLazySingleton<BaseCartRemoteDataSource>(
        () => CartRemoteDataSource());

    //Todo BaseHomeRepository

    sl.registerLazySingleton<BaseCartRepository>(
        () => CartRepository(baseCartRemoteDataSource: sl()));

    //Todo Use Case

    sl.registerLazySingleton(() => GetCartUseCase(baseCartRepository: sl()));
    sl.registerLazySingleton(() => ChangeCartUseCase(baseCartRepository: sl()));
    sl.registerLazySingleton(() => UpdateCartUseCase(baseCartRepository: sl()));

    //Todo Bloc

    sl.registerFactory(() => CartCubit(
          getCartUseCase: sl(),
          changeCartUseCase: sl(),
          updateCartUseCase: sl(),
        ));
  }
}
