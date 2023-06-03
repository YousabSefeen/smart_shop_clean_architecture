import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base cart repository/base_cart_repository.dart';
import '../entities/update_cart.dart';

class UpdateCartUseCase extends BaseUseCase<UpdateCart, UpdateCartParameters> {
  final BaseCartRepository baseCartRepository;

  UpdateCartUseCase({required this.baseCartRepository});

  @override
  Future<Either<Failure, UpdateCart>> call(
      UpdateCartParameters parameters) async {
    return await baseCartRepository.updateCart(parameters);
  }
}

class UpdateCartParameters extends Equatable {
  final int productId;
  final int quantity;

  const UpdateCartParameters({required this.productId, required this.quantity});

  @override
  List<Object> get props => [productId, quantity];
}
