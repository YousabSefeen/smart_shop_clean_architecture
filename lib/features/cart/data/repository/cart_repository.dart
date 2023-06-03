import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
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
    final result = await baseCartRemoteDataSource.getCart();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(
        message: failure.errorMessageModel.message,
      ));
    }
  }

  @override
  Future<Either<Failure, ChangeCart>> changeCart(
      ChangeCartParameters parameters) async {
    final result = await baseCartRemoteDataSource.changeCart(parameters);

    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(
        message: failure.errorMessageModel.message,
      ));
    }
  }

  @override
  Future<Either<Failure, UpdateCart>> updateCart(
      UpdateCartParameters parameters) async {
    final result = await baseCartRemoteDataSource.updateCar(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(
        message: failure.errorMessageModel.message,
      ));
    }
  }
}
