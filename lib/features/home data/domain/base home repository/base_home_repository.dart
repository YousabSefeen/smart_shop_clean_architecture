import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/banners.dart';
import '../entities/products.dart';

abstract class BaseHomeRepository {
  Future<Either<Failure, List<Products>>> getProducts();

  Future<Either<Failure, List<Banners>>> getBanners();
}
