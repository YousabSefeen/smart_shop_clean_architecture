import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/cart.dart';
import '../entities/change_cart.dart';
import '../entities/update_cart.dart';
import '../use cases/change_cart_use_case.dart';
import '../use cases/update_cart_use_case.dart';

abstract class BaseCartRepository {
  Future<Either<Failure, Cart>> getCart();

  Future<Either<Failure, ChangeCart>> changeCart(
      ChangeCartParameters parameters);

  Future<Either<Failure, UpdateCart>> updateCart(
      UpdateCartParameters parameters);
}
