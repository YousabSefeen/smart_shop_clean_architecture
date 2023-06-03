import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
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
    final result = await baseHomeRemoteDataSource.getBanners();

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
  Future<Either<Failure, List<Products>>> getProducts() async {
    final result = await baseHomeRemoteDataSource.getProducts();

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
