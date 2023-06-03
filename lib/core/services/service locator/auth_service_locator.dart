import '../../../features/authentication/data/data source/auth_remote_data_source.dart';
import '../../../features/authentication/data/repository/auth_repository.dart';
import '../../../features/authentication/domain/base auth repository/base_auth_repository.dart';
import '../../../features/authentication/domain/use cases/get_profile_use_case.dart';
import '../../../features/authentication/domain/use cases/login_use_case.dart';
import '../../../features/authentication/domain/use cases/register_use_case.dart';
import '../../../features/authentication/domain/use cases/update_profile_use_case.dart';
import '../../../features/authentication/presentation/controller/cubit/auth_cubit.dart';
import '../../utils/global_constants.dart';

class ProfileServiceLocator {
  void init() {
    /// RemoteDataSource/BaseHomeRepository/Use Case/ Bloc
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
      () => AuthRemoteDataSource(),
    );

    sl.registerLazySingleton<BaseAuthRepository>(
        () => AuthRepository(baseAuthRemoteDataSource: sl()));

    sl.registerLazySingleton(() => LoginUseCase(baseAuthRepository: sl()));
    sl.registerLazySingleton(() => RegisterUseCase(baseAuthRepository: sl()));

    sl.registerLazySingleton(() => GetProfileUseCase(baseAuthRepository: sl()));
    sl.registerLazySingleton(
        () => UpdateProfileUseCase(baseAuthRepository: sl()));
    sl.registerFactory(() => AuthCubit(
          registerUseCase: sl(),
          loginUseCase: sl(),
          getProfileUseCase: sl(),
          updateProfileUseCase: sl(),
        ));
  }
}
