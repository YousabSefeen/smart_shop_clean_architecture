import 'package:dartz/dartz.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base cart repository/base_cart_repository.dart';
import '../entities/cart.dart';

class GetCartUseCase extends BaseUseCase<Cart, NoParameters> {
  final BaseCartRepository baseCartRepository;

  GetCartUseCase({required this.baseCartRepository});

  @override
  Future<Either<Failure, Cart>> call(NoParameters parameters) async {
    return await baseCartRepository.getCart();
  }
}
