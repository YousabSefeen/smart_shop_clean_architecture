import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/base home repository/base_home_repository.dart';
import '../../domain/entities/banners.dart';
import '../../domain/entities/products.dart';
import '../data source/home_remote_data_source.dart';

class HomeRepository extends BaseHomeRepository {
  final BaseHomeRemoteDataSource baseHomeRemoteDataSource;

  HomeRepository({required this.baseHomeRemoteDataSource});

  @override
  Future<Either<Failure, List<Banners>>> getBanners() async {
    try {
      final result = await baseHomeRemoteDataSource.getBanners();

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
  Future<Either<Failure, List<Products>>> getProducts() async {
    try {
      final result = await baseHomeRemoteDataSource.getProducts();

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
