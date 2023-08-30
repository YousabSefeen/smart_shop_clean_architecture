import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/base cart repository/base_cart_repository.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/change_cart.dart';
import '../../domain/entities/update_cart.dart';
import '../../domain/use cases/change_cart_use_case.dart';
import '../../domain/use cases/update_cart_use_case.dart';
import '../data source/cart_remote_data_source.dart';

class CartRepository extends BaseCartRepository {
  final BaseCartRemoteDataSource baseCartRemoteDataSource;

  CartRepository({required this.baseCartRemoteDataSource});

  @override
  Future<Either<Failure, Cart>> getCart() async {
    try {
      final result = await baseCartRemoteDataSource.getCart();
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
  Future<Either<Failure, ChangeCart>> changeCart(
      ChangeCartParameters parameters) async {
    try {
      final result = await baseCartRemoteDataSource.changeCart(parameters);
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
  Future<Either<Failure, UpdateCart>> updateCart(
      UpdateCartParameters parameters) async {
    try {
      final result = await baseCartRemoteDataSource.updateCar(parameters);
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
