import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/base search repository/base_search_products_repository.dart';
import '../../domain/entities/search_products.dart';
import '../../domain/use cases/search_product_use_case.dart';
import '../data source/search_products_remote_data_source.dart';

class SearchProductsRepository extends BaseSearchProductsRepository {
  final BaseSearchProductsRemoteDataSource baseSearchProductsRemoteDataSource;

  SearchProductsRepository({required this.baseSearchProductsRemoteDataSource});

  @override
  Future<Either<Failure, List<SearchProducts>>> getSearchProducts(
      SearchProductsParameters parameters) async {
    final result =
        await baseSearchProductsRemoteDataSource.getSearchProducts(parameters);

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
