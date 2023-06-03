import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/base auth repository/base_auth_repository.dart';
import '../../domain/entities/auth.dart';
import '../../domain/use cases/login_use_case.dart';
import '../data source/auth_remote_data_source.dart';

class AuthRepository extends BaseAuthRepository {
  BaseAuthRemoteDataSource baseAuthRemoteDataSource;

  AuthRepository({required this.baseAuthRemoteDataSource});

  @override
  Future<Either<Failure, Auth>> register(AuthParameters parameters) async {
    final result = await baseAuthRemoteDataSource.register(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(
        message: failure.errorMessageModel.message,
      ));
    }
  }

  @override
  Future<Either<Failure, Auth>> login(AuthParameters parameters) async {
    final result = await baseAuthRemoteDataSource.login(parameters);

    try {
      return right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Auth>> getProfile() async {
    final result = await baseAuthRemoteDataSource.getProfile();

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          message: failure.errorMessageModel.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Auth>> updateProfile(AuthParameters parameters) async {
    final result = await baseAuthRemoteDataSource.updateProfile(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          message: failure.errorMessageModel.message,
        ),
      );
    }
  }
}
