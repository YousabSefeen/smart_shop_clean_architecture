import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base cart repository/base_cart_repository.dart';
import '../entities/change_cart.dart';

class ChangeCartUseCase extends BaseUseCase<ChangeCart, ChangeCartParameters> {
  final BaseCartRepository baseCartRepository;

  ChangeCartUseCase({required this.baseCartRepository});

  @override
  Future<Either<Failure, ChangeCart>> call(
      ChangeCartParameters parameters) async {
    return await baseCartRepository.changeCart(parameters);
  }
}

class ChangeCartParameters extends Equatable {
  final int productId;

  const ChangeCartParameters({required this.productId});

  @override
  List<Object> get props => [productId];
}
