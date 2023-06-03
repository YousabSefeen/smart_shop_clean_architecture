import 'package:dartz/dartz.dart';

import '../../../../core/base  use case/base_use_case.dart';
import '../../../../core/errors/failure.dart';
import '../base home repository/base_home_repository.dart';
import '../entities/products.dart';

class GetProductsUseCase extends BaseUseCase<List<Products>, NoParameters> {
  final BaseHomeRepository baseHomeRepository;

  GetProductsUseCase({required this.baseHomeRepository});

  @override
  Future<Either<Failure, List<Products>>> call(NoParameters parameters) async {
    return await baseHomeRepository.getProducts();
  }
}
