import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/search_products.dart';
import '../use cases/search_product_use_case.dart';

abstract class BaseSearchProductsRepository {
  Future<Either<Failure, List<SearchProducts>>> getSearchProducts(
      SearchProductsParameters parameters);
}
