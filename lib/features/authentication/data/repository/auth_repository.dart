import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

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
    try {
      final result = await baseAuthRemoteDataSource.register(parameters);

      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error: error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Auth>> login(AuthParameters parameters) async {
    try {
      final result = await baseAuthRemoteDataSource.login(parameters);

      return right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error: error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Auth>> getProfile() async {
    try {
      final result = await baseAuthRemoteDataSource.getProfile();

      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error: error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Auth>> updateProfile(AuthParameters parameters) async {
    try {
      final result = await baseAuthRemoteDataSource.updateProfile(parameters);

      return Right(result);
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error: error));
      } else {
        return Left(ServerFailure(error.toString()));
      }
    }
  }
}
